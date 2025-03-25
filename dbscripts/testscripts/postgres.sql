-- Get city from the nested address
SELECT data->'address'->>'city' AS city FROM users;

-- Retrieve the email
SELECT data->>'email' AS email FROM users;

-- Get all orders
SELECT data->'orders' FROM users;

-- Find users who placed an order with amount greater than 200
SELECT * FROM users WHERE EXISTS (
    SELECT 1 FROM jsonb_array_elements(data->'orders') AS orders WHERE (orders->>'amount')::NUMERIC > 200
);

EXPLAIN ANALYZE
INSERT INTO products (name, category, details)
VALUES
    ('Smartphone X', 'Electronics', 
        '{"price": 799.99, "stock": 100, "dimensions": {"width": 7, "height": 14, "depth": 1}, "tags": ["smartphone", "electronics"], "rating": 4.8}'::jsonb),
    ('Laptop Pro', 'Computers', 
        '{"price": 1299.99, "stock": 50, "dimensions": {"width": 30, "height": 20, "depth": 2}, "tags": ["laptop", "gaming"], "rating": 4.6}'::jsonb),
    ('Smart TV', 'Home Appliance', 
        '{"price": 999.99, "stock": 30, "dimensions": {"width": 120, "height": 70, "depth": 10}, "tags": ["tv", "electronics"], "rating": 4.7}'::jsonb),
    ('Bluetooth Speaker', 'Electronics', 
        '{"price": 59.99, "stock": 500, "dimensions": {"width": 10, "height": 10, "depth": 5}, "tags": ["audio", "wireless"], "rating": 4.3}'::jsonb),
    ('Gaming Mouse', 'Computers', 
        '{"price": 49.99, "stock": 200, "dimensions": {"width": 6, "height": 3, "depth": 2}, "tags": ["gaming", "accessory"], "rating": 4.7}'::jsonb),
    ('Wireless Router', 'Networking', 
        '{"price": 179.99, "stock": 75, "dimensions": {"width": 25, "height": 5, "depth": 15}, "tags": ["internet", "Wi-Fi"], "rating": 4.5}'::jsonb);

EXPLAIN ANALYZE
SELECT * FROM products 
WHERE (details->>'price')::NUMERIC > 500;

CREATE INDEX idx_price_jsonb ON products ((CAST(details->>'price' AS NUMERIC)));

EXPLAIN ANALYZE
SELECT * FROM products WHERE (details->>'price')::NUMERIC > 500;

