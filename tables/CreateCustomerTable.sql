-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

CREATE TABLE Customer
(
Cust_id 	number(4) NOT NULL,
Cust_name	varchar2(30) NOT NULL,
Cust_add	varchar2(30),
Phone		varchar2(10),
Email		varchar2(40),
Join_date	date DEFAULT sysdate,
Points		number(3) DEFAULT 0,
Password	varchar2(32)
)
PCTFREE 20
PCTUSED 80
TABLESPACE xjw9075_ts
STORAGE (INITIAL 3M NEXT 500K);
/