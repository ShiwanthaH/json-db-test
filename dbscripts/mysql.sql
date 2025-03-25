CREATE TABLE
    users (id INT PRIMARY KEY, data JSON);

INSERT INTO
    users (id, data)
VALUES
    (
        1,
        '{"name": "John Doe", "email": "john.doe@example.com", "address": {"city": "New York", "zip": "10001"}, "orders": [{"order_id": 101, "amount": 250.5, "status": "shipped"}, {"order_id": 102, "amount": 120.0, "status": "pending"}]}'
    );

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(100),
    details JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
