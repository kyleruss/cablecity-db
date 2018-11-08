-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Adds customers points to the customer cust_num
-- Points are based on the purchase value
-- 1 point per 100 points
-- 3 points bonus if purchase value > 300

CREATE OR REPLACE PROCEDURE addCustomerPoints (cust_num NUMBER, purchase_value
NUMBER)
IS

	CURSOR cust_cursor IS
	SELECT * FROM Customer
	WHERE Cust_id = cust_num;

	r_cust_row			cust_cursor%ROWTYPE;
	v_num_points		Customer.Points%TYPE;
	v_min_purchase		NUMBER;
	v_max_purchase		NUMBER;
	v_bonus_purchase	NUMBER;
	e_cust_notfound		EXCEPTION;

BEGIN

	OPEN cust_cursor;
	IF(cust_cursor%NOTFOUND) 
		THEN RAISE e_cust_notfound;
	ELSE
		FETCH cust_cursor INTO r_cust_row;
	END IF;

	v_min_purchase		:=	100;
	v_max_purchase		:=	500;
	v_bonus_purchase	:=	300;

	IF purchase_value > v_min_purchase AND purchase_value < purchase_value
	THEN
		v_num_points	:=	purchase_value / v_min_purchase;

		IF purchase_value >= v_bonus_purchase
			THEN v_num_points := v_num_points + 3;
		END IF;

		v_num_points := v_num_points + r_cust_row.Points;

		UPDATE Customer
		SET Points = v_num_points
		WHERE Cust_id = cust_num;

	END IF;

EXCEPTION
	WHEN e_cust_notfound
	THEN dbms_output.put_line('Customer was not found');

END;
/
