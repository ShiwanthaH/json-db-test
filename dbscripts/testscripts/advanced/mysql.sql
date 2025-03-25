-- Create table with JSON column
CREATE TABLE json_store (
    id INT IDENTITY(1,1) PRIMARY KEY,
    data NVARCHAR(MAX)
);

-- Stored procedure to insert 1 million rows
CREATE PROCEDURE insert_json_data
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @i INT = 0;
    
    WHILE @i < 1000000
    BEGIN
        INSERT INTO json_store (data) 
        VALUES (
            JSON_OBJECT(
                'id', @i,
                'user', JSON_OBJECT(
                    'name', CONCAT('User_', @i),
                    'age', FLOOR(RAND() * 50 + 20),
                    'address', JSON_OBJECT(
                        'street', CONCAT('Street_', @i),
                        'city', CONCAT('City_', (@i % 100)),
                        'country', CONCAT('Country_', (@i % 50)),
                        'coordinates', JSON_OBJECT(
                            'lat', RAND() * 180 - 90,
                            'lng', RAND() * 360 - 180
                        )
                    ),
                    'contacts', JSON_ARRAY(
                        JSON_OBJECT('type', 'email', 'value', CONCAT('user_', @i, '@example.com')),
                        JSON_OBJECT('type', 'phone', 'value', CONCAT('123456789', (@i % 10)))
                    )
                )
            )
        );
        
        SET @i = @i + 1;
    END
END;

-- Execute the stored procedure to insert data
EXEC insert_json_data;