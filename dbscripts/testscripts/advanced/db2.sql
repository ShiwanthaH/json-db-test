-- Create table with JSON column
CREATE TABLE json_store (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data CLOB
);

-- Stored procedure to insert 1 million rows
CREATE OR REPLACE PROCEDURE insert_json_data()
LANGUAGE SQL
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE json_data CLOB;
    
    WHILE i < 1000000 DO
        SET json_data = JSON_OBJECT(
            'id' VALUE i,
            'user' VALUE JSON_OBJECT(
                'name' VALUE 'User_' || i,
                'age' VALUE INT(RAND() * 50 + 20),
                'address' VALUE JSON_OBJECT(
                    'street' VALUE 'Street_' || i,
                    'city' VALUE 'City_' || (i % 100),
                    'country' VALUE 'Country_' || (i % 50),
                    'coordinates' VALUE JSON_OBJECT(
                        'lat' VALUE (RAND() * 180 - 90),
                        'lng' VALUE (RAND() * 360 - 180)
                    )
                ),
                'contacts' VALUE JSON_ARRAY(
                    JSON_OBJECT('type' VALUE 'email', 'value' VALUE 'user_' || i || '@example.com'),
                    JSON_OBJECT('type' VALUE 'phone', 'value' VALUE '123456789' || (i % 10))
                )
            )
        );
        
        INSERT INTO json_store (data) VALUES (json_data);
        SET i = i + 1;
    END WHILE;
END;

-- Execute the stored procedure to insert data
CALL insert_json_data();
