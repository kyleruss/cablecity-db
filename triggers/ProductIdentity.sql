-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates an identity/AI trigger for Product

CREATE OR REPLACE TRIGGER ProductIdentityTR
BEFORE INSERT ON Product
FOR EACH ROW

DECLARE
next_id		Product.Prod_id%TYPE;

BEGIN
SELECT max(Prod_id)
INTO next_id
FROM Product;

IF next_id IS NULL THEN next_id := 0;
END IF;

:new.Prod_id := next_id + 1;

END;