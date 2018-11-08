-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

CREATE TABLE Sales
(
Sale_id		Number(6) NOT NULL,
Cust_id		Number(4) NOT NULL,
Prod_id		Number(4) NOT NULL,
Desp_id		Number(4) NOT NULL,
Units_sold	Number(4),
Sale_date	date DEFAULT sysdate,
Total_price	Number(8, 2)
)
PCTFREE 5
PCTUSED 95
TABLESPACE xjw9075_ts
STORAGE (INITIAL 47M NEXT 5M);
/



CREATE TABLE Sales
(
Sale_id		Number(6) NOT NULL,
Cust_id		Number(4) NOT NULL,
Prod_id		Number(4) NOT NULL,
Desp_id		Number(4) NOT NULL,
Units_sold	Number(4),
Sale_date	date DEFAULT sysdate,
Total_price	Number(8, 2),
--FOREIGN KEY(Cust_id) REFERENCES Customer(Cust_id) ON DELETE CASCADE,
--FOREIGN KEY(Prod_id) REFERENCES Product(Prod_id) ON DELETE CASCADE,
--FOREIGN KEY(Desp_id) REFERENCES Despatch(Desp_id) ON DELETE CASCADE
)
PCTFREE 5
PCTUSED 95
TABLESPACE xjw9075_ts
STORAGE (INITIAL 47M NEXT 5M);
/