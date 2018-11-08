-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

CREATE OR REPLACE TRIGGER AfterSaleTR
AFTER INSERT ON Sales
FOR EACH ROW

BEGIN

-- Decreases the despatch stock by the number of units sold
DecreaseDispStock(:new.Desp_id, :new.Units_sold);

-- Adds the customer points to the customer who made the sale
-- Points added are based on the total price
AddCustomerPoints(:new.Desp_id, :new.Total_price);

END;
/
