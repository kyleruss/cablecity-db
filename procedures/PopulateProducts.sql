-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates num_products many products in the Product table
-- Products are randomly generated and their values are sample

CREATE OR REPLACE PROCEDURE populateProducts (num_products NUMBER)
IS

	v_id		Product.Prod_id%TYPE;
	v_name		Product.Prod_name%TYPE;
	v_desc		Product.Prod_desc%TYPE;
	v_quant		Product.QOH%TYPE;
	v_price		Product.Prod_Price%TYPE;
	
	v_quant_len	NUMBER(5);
	v_price_len	NUMBER(8);
	
	
BEGIN

	FOR i IN 1..num_products LOOP
		-- Get next ID/index number for names, desc etc.
		-- ID increments is handled by prod_identity_tr
		SELECT max(Prod_id)
		INTO v_id
		FROM Product;
		
		IF v_id IS NULL THEN v_id := 0;
		END IF;

		v_id 	:= 	v_id + 1;
		
		v_name 	:=	'Product' || v_id;
		v_desc	:=	v_name || ' - sample description';
		
		-- Generate product QOH
		v_quant_len	:=	500;

		SELECT dbms_random.value(1, v_quant_len)
		INTO v_quant
		FROM dual;
		
		-- Generate product price
		v_price_len	:=	500;
		
		SELECT dbms_random.value(1, v_price_len)
		INTO v_price
		FROM dual;
		
		INSERT INTO Product (Prod_name, Prod_desc, QOH, Prod_Price)
		VALUES
		(
			v_name,
			v_desc,
			v_quant,
			v_price
		);
	END LOOP;
END;
/
