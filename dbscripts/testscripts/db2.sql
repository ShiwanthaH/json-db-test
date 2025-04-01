-- Get city from the nested address
SELECT JSON_VALUE(data, '$.address.city') AS city FROM users;

-- Retrieve the email
SELECT JSON_VALUE(data, '$.email') AS email FROM users;

-- Get all orders
SELECT data->'orders' FROM users;

-- Find users who placed an order with amount greater than 200
SELECT * FROM users 
WHERE EXISTS (
    SELECT 1 
    FROM JSON_TABLE(data, '$.orders[*]' 
        COLUMNS (
            amount DECIMAL(10,2) PATH '$.amount'
        )
    ) AS orders 
    WHERE orders.amount > 200
);

-- Insert products with JSON details
INSERT INTO products (name, category, details)
VALUES
    ('Smartphone X', 'Electronics', 
        JSON_OBJECT(
            'price': 799.99, 
            'stock': 100, 
            'dimensions': JSON_OBJECT(
                'width': 7, 
                'height': 14, 
                'depth': 1
            ),
            'tags': JSON_ARRAY('smartphone', 'electronics'),
            'rating': 4.8
        )
    ),
    ('Laptop Pro', 'Computers', 
        JSON_OBJECT(
            'price': 1299.99, 
            'stock': 50, 
            'dimensions': JSON_OBJECT(
                'width': 30, 
                'height': 20, 
                'depth': 2
            ),
            'tags': JSON_ARRAY('laptop', 'gaming'),
            'rating': 4.6
        )
    ),
    ('Smart TV', 'Home Appliance', 
        JSON_OBJECT(
            'price': 999.99, 
            'stock': 30, 
            'dimensions': JSON_OBJECT(
                'width': 120, 
                'height': 70, 
                'depth': 10
            ),
            'tags': JSON_ARRAY('tv', 'electronics'),
            'rating': 4.7
        )
    ),
    ('Bluetooth Speaker', 'Electronics', 
        JSON_OBJECT(
            'price': 59.99, 
            'stock': 500, 
            'dimensions': JSON_OBJECT(
                'width': 10, 
                'height': 10, 
                'depth': 5
            ),
            'tags': JSON_ARRAY('audio', 'wireless'),
            'rating': 4.3
        )
    ),
    ('Gaming Mouse', 'Computers', 
        JSON_OBJECT(
            'price': 49.99, 
            'stock': 200, 
            'dimensions': JSON_OBJECT(
                'width': 6, 
                'height': 3, 
                'depth': 2
            ),
            'tags': JSON_ARRAY('gaming', 'accessory'),
            'rating': 4.7
        )
    ),
    ('Wireless Router', 'Networking', 
        JSON_OBJECT(
            'price': 179.99, 
            'stock': 75, 
            'dimensions': JSON_OBJECT(
                'width': 25, 
                'height': 5, 
                'depth': 15
            ),
            'tags': JSON_ARRAY('internet', 'Wi-Fi'),
            'rating': 4.5
        )
    );

-- Select products with price > 500
SELECT * FROM products 
WHERE DECIMAL(JSON_VALUE(details, '$.price')) > 500;

-- Create an index on the price
CREATE INDEX idx_price_json ON products 
    GENERATED ALWAYS AS (DECIMAL(JSON_VALUE(details, '$.price')));

-- Re-run the price filter query to utilize the index
SELECT * FROM products 
WHERE DECIMAL(JSON_VALUE(details, '$.price')) > 500;