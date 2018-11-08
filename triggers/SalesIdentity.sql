-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates an identity/AI trigger for Sales

CREATE OR REPLACE TRIGGER SaleIdentityTR
BEFORE INSERT ON Sales
FOR EACH ROW

DECLARE
next_id		Sales.Sale_id%TYPE;

BEGIN
SELECT max(Sale_id)
INTO next_id
FROM Sales;

IF next_id IS NULL THEN next_id := 0;
END IF;

:new.Sale_id := next_id + 1;

END;
/