-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Checks the password entered by cust_num and returns 1/0 if correct or false if password matches
-- Passwords are hashed and validated with the stored password

CREATE OR REPLACE PROCEDURE checkPassword(cust_num NUMBER, cust_password
varchar2, isCorrect OUT NUMBER)
IS
	v_salt				varchar2(16);
	v_hashed_pass		varchar2(32);
	v_stored_pass		varchar2(32);
	e_user_notfound		EXCEPTION;

	CURSOR cust_cursor IS
	SELECT * FROM Customer
	WHERE Cust_id = cust_num;

	r_cust_row			cust_cursor%ROWTYPE;

BEGIN


OPEN cust_cursor;
IF(cust_cursor%NOTFOUND) 
	THEN RAISE e_user_notfound;
ELSE
	FETCH cust_cursor INTO r_cust_row;
END IF;

-- Uses the customers first name as the salt
v_salt			:=	r_cust_row.Cust_name;
v_stored_pass	:=	r_cust_row.Password;

-- create hash to match with the stored hash
makePasswordHash(cust_password, v_salt, v_hashed_pass);

IF(v_hashed_pass = v_stored_pass)
	THEN isCorrect := 1;
ELSE
	isCorrect := 0;
END IF;

EXCEPTION
	WHEN e_user_notfound
	THEN dbms_output.put_line('User was not found');

END;
/
