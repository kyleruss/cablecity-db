-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Creates the shop_dev role
CREATE ROLE shop_dev;

-- Grant sys privileges as per design requirements
GRANT
ALTER ANY INDEX,
ALTER ANY TABLE,
ALTER ANY PROCEDURE,
CREATE ANY INDEX,
CREATE ANY PROCEDURE,
CREATE TABLE,
CREATE TRIGGER,
CREATE SESSION,
DROP ANY INDEX,
DROP ANY PROCEDURE,
DROP ANY TRIGGER
TO shop_dev;

-- Grant obj privileges as per design requirements
GRANT
SELECT,
INSERT,
UPDATE,
DELETE
ON Sales, Customer, Product, Despatch
TO shop_dev;


-- Creates the shop_dev_profile
-- For design commentary see report
CREATE PROFILE shop_dev_profile
LIMIT
SESSIONS_PER_USER 2
CONNECT_TIME UNLIMITED
FAILED_LOGIN_ATTEMPTS 4
PASSWORD_REUSE_MAX 1
PASSWORD_LOCK_TIME 30/1440
PASSWORD_LIFE_TIME 30
PASSWORD_GRACE_TIME 3
PASSWORD_REUSE_TIME 60
IDLE_TIME 30;

-- Creates the dev user
CREATE USER xjw9075_dev IDENTIFIED BY Kyleruss1030
PROFILE shop_dev_profile
DEFAULT TABLESPACE xjw9075_ts
QUOTA UNLIMITED ON xjw9075_ts;

-- Grant shop_dev to the newely created user
GRANT shop_dev TO xjw9075_dev;