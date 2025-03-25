-- Get city from the nested address
SELECT
    data->'$.address.city' AS city
FROM
    users;

-- Retrieve the email
SELECT data->'$.email' AS email FROM users;

-- Get all orders
SELECT
    JSON_EXTRACT (data, '$.orders')
FROM
    users;

SET @doc = (SELECT data FROM users WHERE id = 1);

-- Find users who placed an order with amount greater than 200
SELECT JSON_SEARCH (@doc, 'all', '250.5', NULL, '$.orders[*].amount') IS NOT NULL;

-- Find users who placed an order with amount greater than 300
UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME = 'events_statements_history_long';

INSERT INTO products (name, category, details)
VALUES
    ('Smartphone X', 'Electronics', 
        '{"price": 799.99, "stock": 100, "dimensions": {"width": 7, "height": 14, "depth": 1}, "tags": ["smartphone", "electronics"], "rating": 4.8}'),
    ('Laptop Pro', 'Computers', 
        '{"price": 1299.99, "stock": 50, "dimensions": {"width": 30, "height": 20, "depth": 2}, "tags": ["laptop", "gaming"], "rating": 4.6}'),
    ('Smart TV', 'Home Appliance', 
        '{"price": 999.99, "stock": 30, "dimensions": {"width": 120, "height": 70, "depth": 10}, "tags": ["tv", "electronics"], "rating": 4.7}'),
    ('Bluetooth Speaker', 'Electronics', 
        '{"price": 59.99, "stock": 500, "dimensions": {"width": 10, "height": 10, "depth": 5}, "tags": ["audio", "wireless"], "rating": 4.3}'),
    ('Gaming Mouse', 'Computers', 
        '{"price": 49.99, "stock": 200, "dimensions": {"width": 6, "height": 3, "depth": 2}, "tags": ["gaming", "accessory"], "rating": 4.7}'),
    ('Wireless Headphones', 'Electronics', 
        '{"price": 149.99, "stock": 120, "dimensions": {"width": 15, "height": 20, "depth": 10}, "tags": ["audio", "bluetooth"], "rating": 4.5}'),
    ('4K Monitor', 'Computers', 
        '{"price": 399.99, "stock": 40, "dimensions": {"width": 80, "height": 50, "depth": 5}, "tags": ["display", "gaming"], "rating": 4.8}'),
    ('Smart Watch', 'Electronics', 
        '{"price": 249.99, "stock": 300, "dimensions": {"width": 4, "height": 4, "depth": 1}, "tags": ["wearable", "fitness"], "rating": 4.6}'),
    ('Home Theater System', 'Home Appliance', 
        '{"price": 799.99, "stock": 25, "dimensions": {"width": 150, "height": 80, "depth": 20}, "tags": ["audio", "cinema"], "rating": 4.9}'),
    ('Mechanical Keyboard', 'Computers', 
        '{"price": 129.99, "stock": 60, "dimensions": {"width": 45, "height": 5, "depth": 20}, "tags": ["keyboard", "gaming"], "rating": 4.7}'),
    ('Drone Pro', 'Electronics', 
        '{"price": 1199.99, "stock": 15, "dimensions": {"width": 30, "height": 30, "depth": 10}, "tags": ["drone", "camera"], "rating": 4.8}'),
    ('VR Headset', 'Electronics', 
        '{"price": 349.99, "stock": 35, "dimensions": {"width": 20, "height": 15, "depth": 10}, "tags": ["virtual reality", "gaming"], "rating": 4.5}'),
    ('Electric Scooter', 'Vehicles', 
        '{"price": 699.99, "stock": 20, "dimensions": {"width": 110, "height": 120, "depth": 30}, "tags": ["transport", "eco"], "rating": 4.4}'),
    ('Smart Refrigerator', 'Home Appliance', 
        '{"price": 1499.99, "stock": 10, "dimensions": {"width": 90, "height": 180, "depth": 70}, "tags": ["kitchen", "smart"], "rating": 4.8}'),
    ('Fitness Tracker', 'Electronics', 
        '{"price": 99.99, "stock": 500, "dimensions": {"width": 3, "height": 1, "depth": 1}, "tags": ["wearable", "health"], "rating": 4.3}'),
    ('Gaming Chair', 'Furniture', 
        '{"price": 299.99, "stock": 75, "dimensions": {"width": 50, "height": 120, "depth": 50}, "tags": ["ergonomic", "gaming"], "rating": 4.7}'),
    ('Robot Vacuum', 'Home Appliance', 
        '{"price": 499.99, "stock": 50, "dimensions": {"width": 40, "height": 10, "depth": 40}, "tags": ["cleaning", "robotic"], "rating": 4.6}'),
    ('Smart Thermostat', 'Home Automation', 
        '{"price": 199.99, "stock": 100, "dimensions": {"width": 10, "height": 10, "depth": 3}, "tags": ["temperature", "climate"], "rating": 4.4}'),
    ('E-Book Reader', 'Electronics', 
        '{"price": 159.99, "stock": 150, "dimensions": {"width": 15, "height": 20, "depth": 1}, "tags": ["reading", "digital"], "rating": 4.5}'),
    ('Car Dash Cam', 'Automobile', 
        '{"price": 129.99, "stock": 90, "dimensions": {"width": 10, "height": 5, "depth": 3}, "tags": ["safety", "camera"], "rating": 4.6}'),
    ('Security Camera', 'Home Security', 
        '{"price": 179.99, "stock": 75, "dimensions": {"width": 10, "height": 10, "depth": 5}, "tags": ["surveillance", "smart"], "rating": 4.7}'),
    ('Air Purifier', 'Home Appliance', 
        '{"price": 249.99, "stock": 80, "dimensions": {"width": 30, "height": 60, "depth": 30}, "tags": ["clean air", "health"], "rating": 4.8}'),
    ('Portable Projector', 'Electronics', 
        '{"price": 349.99, "stock": 60, "dimensions": {"width": 15, "height": 10, "depth": 5}, "tags": ["cinema", "portable"], "rating": 4.5}'),
    ('Coffee Maker', 'Kitchen Appliance', 
        '{"price": 89.99, "stock": 200, "dimensions": {"width": 20, "height": 30, "depth": 15}, "tags": ["coffee", "brewing"], "rating": 4.4}'),
    ('Smart Door Lock', 'Home Security', 
        '{"price": 229.99, "stock": 40, "dimensions": {"width": 15, "height": 20, "depth": 5}, "tags": ["security", "smart"], "rating": 4.6}'),
    ('Noise Cancelling Earbuds', 'Electronics', 
        '{"price": 199.99, "stock": 120, "dimensions": {"width": 2, "height": 2, "depth": 1}, "tags": ["audio", "wireless"], "rating": 4.7}'),
    ('Smart Light Bulb', 'Home Automation', 
        '{"price": 29.99, "stock": 500, "dimensions": {"width": 5, "height": 10, "depth": 5}, "tags": ["lighting", "smart"], "rating": 4.3}'),
    ('Wireless Router', 'Networking', 
        '{"price": 179.99, "stock": 75, "dimensions": {"width": 25, "height": 5, "depth": 15}, "tags": ["internet", "Wi-Fi"], "rating": 4.5}');

-- SET @end = NOW(3);

SELECT * FROM products 
WHERE details->'$.price' > 500;

-- Add index on price column
ALTER TABLE products ADD COLUMN price DECIMAL(10,2) AS (details->'$.price') STORED;
ALTER TABLE products ADD INDEX idx_price (price);


-- Retrieve products with price greater than 500
SELECT * FROM products WHERE price > 500;


SELECT EVENT_ID, SQL_TEXT, TIMER_WAIT/1000000000 AS time_in_ms
FROM performance_schema.events_statements_history_long
ORDER BY EVENT_ID DESC;

TRUNCATE TABLE performance_schema.events_statements_history_long;