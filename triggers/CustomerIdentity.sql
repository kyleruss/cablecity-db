-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates an identity/AI trigger for Customer

CREATE OR REPLACE TRIGGER CustIdentityTR
BEFORE INSERT ON Customer
FOR EACH ROW

DECLARE
next_id		Customer.Cust_id%TYPE;

BEGIN
SELECT max(Cust_id)
INTO next_id
FROM Customer;

IF next_id IS NULL THEN next_id := 0;
END IF;

:new.Cust_id := next_id + 1;

END;
/