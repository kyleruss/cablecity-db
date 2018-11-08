-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

CREATE TABLE Product
(
Prod_id		Number(4) NOT NULL,
Prod_name	varchar2(30) NOT NULL,
Prod_desc	varchar2(40) NOT NULL,
QOH		Number(5) DEFAULT 0,
Prod_Price	Number(8, 2) NOT NULL,
Added_date	date DEFAULT sysdate
)
PCTFREE 15
PCTUSED 85
TABLESPACE xjw9075_ts
STORAGE (INITIAL 608K NEXT 200K);
/