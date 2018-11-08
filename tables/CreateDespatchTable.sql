-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

CREATE TABLE despatch
(
	Desp_id		number(4) NOT NULL,
	Prod_name	varchar2(30) NOT NULL,
	ShelfLoc	varchar2(6) NOT NULL,
	Quantity	Number(5) DEFAULT 0
)
PCTFREE 20
PCTUSED 80
TABLESPACE xjw9075_ts
STORAGE (INITIAL 304K NEXT 200K);
/