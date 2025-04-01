-- Get city from the nested address
SELECT JSON_VALUE(data, '$.address.city') AS city 
FROM users;

-- Retrieve the email
SELECT JSON_VALUE(data, '$.email') AS email 
FROM users;

-- Get all orders
SELECT JSON_QUERY(data, '$.orders') AS orders 
FROM users;

-- Find users who placed an order with amount greater than 200
SELECT id 
FROM users 
WHERE JSON_EXISTS(data, '$.orders[*]?(@.amount > 200)');

-- Find users who placed an order with amount greater than 300
SELECT id 
FROM users 
WHERE JSON_EXISTS(data, '$.orders[*]?(@.amount > 300)');

-- Insert data into products
INSERT INTO products (name, category, details)
VALUES 
    ('Smartphone X', 'Electronics', 
        '{
            "price": 799.99, "stock": 100, "dimensions": {"width": 7, "height": 14, "depth": 1}, 
            "tags": ["smartphone", "electronics"], "rating": 4.8
        }'),
    ('Laptop Pro', 'Computers', 
        '{
            "price": 1299.99, "stock": 50, "dimensions": {"width": 30, "height": 20, "depth": 2}, 
            "tags": ["laptop", "gaming"], "rating": 4.6
        }');

-- Retrieve products with price greater than 500
SELECT * FROM products 
WHERE JSON_VALUE(details, '$.price' RETURNING NUMBER) > 500;

-- Add a virtual column for price
ALTER TABLE products ADD price NUMBER GENERATED ALWAYS AS 
(JSON_VALUE(details, '$.price' RETURNING NUMBER));

-- Add an index on the price column
CREATE INDEX idx_price ON products(price);
