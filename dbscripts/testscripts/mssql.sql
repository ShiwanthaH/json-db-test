-- Get city from the nested address\
DECLARE @StartTime DATETIME2 = SYSDATETIME()
SELECT
    JSON_VALUE (data, '$.address.city') AS city
FROM
    users;
DECLARE @EndTime DATETIME2 = SYSDATETIME();

SELECT DATEDIFF(MICROSECOND, @StartTime, @EndTime) AS ExecutionTimeMicroseconds;

-- Retrieve the email
DECLARE @StartTime2 DATETIME2 = SYSDATETIME()
SELECT
    JSON_VALUE (data, '$.email') AS email
FROM
    users;
DECLARE @EndTime2 DATETIME2 = SYSDATETIME();

SELECT DATEDIFF(MICROSECOND, @StartTime2, @EndTime2) AS ExecutionTimeMicroseconds;

-- Get all orders
DECLARE @StartTime3 DATETIME2 = SYSDATETIME()
SELECT
    data
FROM
    users
WHERE
    JSON_QUERY (data, '$.orders') IS NOT NULL;
DECLARE @EndTime3 DATETIME2 = SYSDATETIME();

SELECT DATEDIFF(MICROSECOND, @StartTime3, @EndTime3) AS ExecutionTimeMicroseconds;

-- Find users who placed an order with amount greater than 200

-- SELECT
--     *
-- FROM
--     users
-- WHERE
--     JSON_VALUE (data, '$.orders[0].amount') > 200;
-- SET
--     STATISTICS TIME OFF;

-- -- Create an index on the city field
ALTER TABLE users ADD vCity AS JSON_VALUE (data, '$.address.city');

SET QUOTED_IDENTIFIER ON;

CREATE INDEX idx_city ON users(vCity);

-- Get city from the nested address
DECLARE @StartTime4 DATETIME2 = SYSDATETIME()
SELECT
    JSON_VALUE (data, '$.address.city') AS city
FROM
    users;
DECLARE @EndTime4 DATETIME2 = SYSDATETIME();

SELECT DATEDIFF(MICROSECOND, @StartTime4, @EndTime4) AS ExecutionTimeMicroseconds;