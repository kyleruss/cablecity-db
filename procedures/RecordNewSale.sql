-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Records a new sale in the Sales table
-- ID's passed are checked to ensure integretity
-- Quantities and Customer points are updated on the AFTER INSERT trigger for Sales

CREATE OR REPLACE PROCEDURE recordNewSale (cust_num NUMBER, prod_num NUMBER,
desp_num NUMBER, num_units NUMBER)
IS

	v_total_value			Sales.Total_price%TYPE;
	v_units_available		Despatch.Quantity%TYPE;
	v_next_quantity			Despatch.Quantity%TYPE;

	e_insufficient_stock	EXCEPTION;
	e_invalid_customer		EXCEPTION;
	e_invalid_product		EXCEPTION;
	e_invalid_despatch		EXCEPTION;


	CURSOR cust_cursor IS
	SELECT * FROM Customer
	WHERE Cust_id = cust_num;

	CURSOR prod_cursor IS
	SELECT * FROM Product
	WHERE Prod_id = prod_num;

	CURSOR desp_cursor IS
	SELECT * FROM Despatch
	WHERE Desp_id = desp_num;

	r_cust_row				cust_cursor%ROWTYPE;
	r_prod_row				prod_cursor%ROWTYPE;
	r_desp_row				desp_cursor%ROWTYPE;


BEGIN

	OPEN cust_cursor;
	IF(cust_cursor%NOTFOUND)
		THEN RAISE e_invalid_customer;
	ELSE
		FETCH cust_cursor INTO r_cust_row;
	END IF;

	OPEN prod_cursor;
	IF(prod_cursor%NOTFOUND)
		THEN RAISE e_invalid_product;
	ELSE
		FETCH prod_cursor INTO r_prod_row;
	END IF;

	OPEN desp_cursor;
	IF(desp_cursor%NOTFOUND)
		THEN RAISE e_invalid_despatch;
	ELSE
		FETCH desp_cursor INTO r_desp_row;
	END IF;
	
	-- Generate the despatch next quantity
	-- next quantity will be  < 0 when num_units is more than the available quantity
	v_units_available	:=	r_desp_row.Quantity;
	v_next_quantity		:=	v_units_available - num_units;

	IF(v_next_quantity < 0) THEN RAISE e_insufficient_stock;
	END IF;

	-- Set sale value based on PRICE * NUM_UNITS
	v_total_value		:=	r_prod_row.Prod_Price * num_units;

	-- Create the sales record
	INSERT INTO Sales (Cust_id, Prod_id, Desp_id, Units_sold, Total_price)
	VALUES
	(
		cust_num,
		prod_num,
		desp_num,
		num_units,
		v_total_value
	);

	

	EXCEPTION 

		WHEN e_insufficient_stock
		THEN dbms_output.put_line('Not enough stock to make purchase');

		WHEN e_invalid_customer
		THEN dbms_output.put_line('Customer not found');

		WHEN e_invalid_product
		THEN dbms_output.put_line('Product not found');

		WHEN e_invalid_despatch
		THEN dbms_output.put_line('Dispatch not found');

	CLOSE cust_cursor;
	CLOSE prod_cursor;
	CLOSE desp_cursor;
END;
/
