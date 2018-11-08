-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Takes plain text password and salt and outputs it's salted hash
-- Typically the Customers first name should be used as the salt

CREATE OR REPLACE PROCEDURE makePasswordHash (plain_pass varchar2, salt varchar2, hashed_pass OUT varchar2)
IS
v_salted_pass	varchar2(32);
v_hash_str	varchar2(32);

BEGIN

  -- concatenate salted pass
  v_salted_pass	:=	plain_pass || salt;
	
  -- Uses ora_hash
  -- Package dbms_crypto was unavailable
  SELECT '' || ora_hash(v_salted_pass)
  INTO v_hash_str
  FROM dual;

    -- output salted hash
	hashed_pass	  :=	v_hash_str;
END;
