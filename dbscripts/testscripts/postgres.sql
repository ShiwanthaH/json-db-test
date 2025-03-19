EXPLAIN ANALYZE
-- Get city from the nested address
SELECT data->'address'->>'city' AS city FROM users;

EXPLAIN ANALYZE
-- Retrieve the email
SELECT data->>'email' AS email FROM users;

EXPLAIN ANALYZE
-- Get all orders
SELECT data->'orders' FROM users;

EXPLAIN ANALYZE
-- Find users who placed an order with amount greater than 200
SELECT * FROM users WHERE EXISTS (
    SELECT 1 FROM jsonb_array_elements(data->'orders') AS orders WHERE (orders->>'amount')::NUMERIC > 200
);

CREATE INDEX idx_city ON users USING GIN (data);

EXPLAIN ANALYZE
-- Get city from the nested address
SELECT data->'address'->>'city' AS city FROM users;