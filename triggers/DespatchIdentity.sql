-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates an identity/AI trigger for Despatch

CREATE OR REPLACE TRIGGER DespatchIdentityTR
BEFORE INSERT ON Despatch
FOR EACH ROW

DECLARE
next_id		Despatch.Desp_id%TYPE;

BEGIN
SELECT max(Desp_id)
INTO next_id
FROM Despatch;

IF next_id IS NULL THEN next_id := 0;
END IF;

:new.Desp_id := next_id + 1;

END;
/