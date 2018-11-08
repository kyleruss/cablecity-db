-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates the shop DBA role
CREATE ROLE shop_dba;

-- Give DBA privileges to the shop_dba
GRANT ALL PRIVILEGES TO shop_dba;

-- Creates the profile as per policy requirements
CREATE PROFILE shop_dba_profile 
LIMIT
SESSIONS_PER_USER 1
CONNECT_TIME UNLIMITED
FAILED_LOGIN_ATTEMPTS 2
PASSWORD_REUSE_MAX 1
PASSWORD_LOCK_TIME 30/1440
PASSWORD_LIFE_TIME 10
QUOTA UNLIMITED ON xjw9075_ts
IDLE_TIME 15;

-- Creates the DBA user
CREATE USER xjw9075_dba IDENTIFIED BY Kyleruss2030
PROFILE shop_dba_profile 
DEFAULT TABLESPACE xjw9075_ts
QUOTA UNLIMITED ON xjw9075_ts;

-- Grants shop_dba to the DBA user
GRANT shop_dba TO xjw9075_dba;