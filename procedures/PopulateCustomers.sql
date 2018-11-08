-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates num_customers many customers in the Customer table
-- Customers are randomly generated and their values are sample

CREATE OR REPLACE PROCEDURE populateCustomers (num_customers NUMBER)
IS
    v_id		    Customer.Cust_id%TYPE;
    v_name		    Customer.Cust_name%TYPE;
    v_addr		    Customer.Cust_add%TYPE;
    v_phone		    Customer.Phone%TYPE;
    v_email       	Customer.Email%TYPE;
    v_pass		    Customer.Password%TYPE;
    v_hashed_pass	Customer.Password%TYPE;
    v_index       	NUMBER(4);

	v_street_number NUMBER(2);
	v_phone_length 	NUMBER(3);
	v_email_num 	NUMBER(3);

BEGIN

	FOR i IN 1..num_customers LOOP
		SELECT max(Cust_id)
		INTO v_id
		FROM Customer;
		
		IF v_id IS NULL THEN v_id := 0;
		END IF;
		
		v_id := v_id + 1;
		
		--Customer name
		v_name := 'Customer' || v_id;
		
		-- Customer address
		SELECT dbms_random.value(0, 10)
		INTO v_street_number
		FROM dual;
		
		v_addr  :=  '' || v_street_number || ' street';
		
		-- Customer phone
		SELECT length(max(Phone))
		INTO v_phone_length
		FROM Customer;
		
		SELECT dbms_random.value(0, v_phone_length)
		INTO v_phone
		FROM dual;
		
		-- Customer email
		SELECT dbms_random.value(0, 100)
		INTO v_email_num
		FROM dual;
		
		v_email := v_name || v_email_num || '@mail.com';
		
		-- Customer password
		SELECT dbms_random.string('A', 16)
		INTO v_pass
		FROM dual;
		
		-- Hash password using proc makePasswordHash
		-- Salt is the users name
		makePasswordHash(v_pass, v_name, v_hashed_pass);
		
		INSERT INTO Customer (Cust_name, Cust_add, Phone, Email, Password)
		VALUES
		(
			v_name,
			v_addr,
			v_phone,
			v_email,
			v_hashed_pass   
		);
	END LOOP;
END;