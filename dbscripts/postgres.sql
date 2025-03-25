CREATE TABLE
    users (id SERIAL PRIMARY KEY, data JSONB);

EXPLAIN ANALYZE
INSERT INTO
    users (data)
VALUES
    (
        '{"name": "John Doe", "email": "john.doe@example.com", "address": {"city": "New York", "zip": "10001"}, "orders": [{"order_id": 101, "amount": 250.5, "status": "shipped"}, {"order_id": 102, "amount": 120.0, "status": "pending"}]}'
    );

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(100),
    details JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

