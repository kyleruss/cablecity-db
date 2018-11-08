-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates num_sales many sales in the Sales table
-- Sales are randomly generated
-- Sale record is created by RecordNewSale proc

CREATE OR REPLACE PROCEDURE populateSales (num_sales NUMBER)
IS
	v_desp_id		Despatch.Desp_id%TYPE;
	v_cust_id		Customer.Cust_id%TYPE;
	v_prod_id		Product.Prod_id%TYPE;
	v_quant			Despatch.Quantity%TYPE;

	v_desp_maxid	NUMBER(8);
	v_cust_maxid	NUMBER(8);
	v_prod_maxid	NUMBER(8);
	v_quant_max		NUMBER(8);

	v_desp_found	NUMBER(1);
	v_cust_found	NUMBER(1);
	v_prod_found	NUMBER(1);

	e_no_customers	EXCEPTION;
	e_no_products	EXCEPTION;
	e_no_dispatch	EXCEPTION;

BEGIN

------------------------------------------------------
--				SELECT MAX IDS
------------------------------------------------------
SELECT max(Desp_id)
INTO v_desp_maxid
FROM Despatch;

IF(v_desp_maxid = 0) THEN RAISE e_no_dispatch;
END IF;

SELECT max(Cust_id)
INTO v_cust_maxid
FROM Customer;

IF(v_cust_maxid = 0) THEN RAISE e_no_customers;
END IF;

SELECT max(Prod_id)
INTO v_prod_maxid
FROM Product;

IF(v_prod_maxid = 0) THEN RAISE e_no_products;
END IF;

------------------------------------------------------

FOR i IN 1..num_sales LOOP

	-- v_xx_found is 1 when a randomly generated ID is found
	
	v_desp_found	:=	0;
	v_cust_found	:=	0;
	v_prod_found	:=	0;

	IF(v_desp_found = 0) THEN
		LOOP
			SELECT dbms_random.value(1, v_desp_maxid)
			INTO v_desp_id
			FROM dual;
			
			SELECT count(*)
			INTO v_desp_found
			FROM Despatch
			WHERE Desp_id = v_desp_id;

			EXIT WHEN v_desp_found = 1;
		END LOOP;
	END IF;

	IF(v_cust_found = 0) THEN
		LOOP
			SELECT dbms_random.value(1, v_cust_maxid)
			INTO v_cust_id
			FROM dual;
			
			SELECT count(*)
			INTO v_cust_found
			FROM Customer
			WHERE Cust_id = v_cust_id;

			EXIT WHEN v_cust_found = 1;	
		END LOOP;
	END IF;

	IF(v_prod_found = 0) THEN
		LOOP
			SELECT dbms_random.value(1, v_prod_maxid)
			INTO v_prod_id
			FROM dual;
			
			SELECT count(*)
			INTO v_prod_found
			FROM Product
			WHERE Prod_id = v_prod_id;

			EXIT WHEN v_prod_found = 1;	
		END LOOP;
	END IF;

	-- Generate the num units of the sale
	SELECT Quantity
	INTO v_quant_max
	FROM Despatch
	WHERE Desp_id = v_desp_id;

	SELECT dbms_random.value(1, v_quant_max)
	INTO v_quant
	FROM dual;

	recordNewSale(v_cust_id, v_prod_id, v_desp_id, v_quant);
END LOOP;

EXCEPTION
	WHEN e_no_customers
	THEN dbms_output.put_line('No customers were found');

	WHEN e_no_products
	THEN dbms_output.put_line('No products were found');

	WHEN e_no_dispatch
	THEN dbms_output.put_line('No dispatch was found');

	

END;
/
