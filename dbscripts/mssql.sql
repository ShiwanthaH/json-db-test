CREATE TABLE
    users (id INT PRIMARY KEY, data NVARCHAR (MAX));

DECLARE @StartTime DATETIME2 = SYSDATETIME()
INSERT INTO
    users (id, data)
VALUES
    (
        1,
        N'{"name": "John Doe", "email": "john.doe@example.com", "address": {"city": "New York", "zip": "10001"}, "orders": [{"order_id": 101, "amount": 250.5, "status": "shipped"}, {"order_id": 102, "amount": 120.0, "status": "pending"}]}'
    );
DECLARE @EndTime DATETIME2 = SYSDATETIME();

SELECT DATEDIFF(MICROSECOND, @StartTime, @EndTime) AS ExecutionTimeMicroseconds;