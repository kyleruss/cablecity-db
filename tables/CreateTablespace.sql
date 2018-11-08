-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------


-- Creates the tablespace for the Cable City database
-- For size calculation please see table_estimation.txt

CREATE TABLESPACE xjw9075_ts
DATAFILE '/usr/local/apps/oracle/oradata/ldb30/xjw9075_ts04.dat' SIZE 55M
AUTOEXTEND ON NEXT 20M MAXSIZE 200M
EXTENT MANAGEMENT LOCAL UNIFORM;