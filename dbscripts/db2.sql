-- Create users table with identity column for auto-incrementing primary key
CREATE TABLE users (
    id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    data BLOB(10M)
);

-- Insert sample data using JSON2BSON for DB2 JSON storage
INSERT INTO users (id, data)
VALUES (
    DEFAULT,
    SYSTOOLS.JSON2BSON(
        '{
        "name": "John Doe",
        "email": "john.doe@example.com",
        "address": {"city": "New York", "zip": "10001"},
        "orders": [
            {"order_id": "101", "amount": "250.5", "status": "shipped"},
            {"order_id": "102", "amount": "120.0", "status": "pending"}
        ]
        }'
    )
);

-- Create products table
CREATE TABLE products (
    id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(100),
    details BLOB(10M),
    created_at TIMESTAMP DEFAULT CURRENT TIMESTAMP
);

CREATE TABLE CLAIMS (CLAIM_ID       VARCHAR(10),
                     POLICY_NUM     VARCHAR(12),
                     CUSTOMER_ID    VARCHAR(8),
                     STATUS         VARCHAR(20),
                     CALL_RECORDS   BLOB);

INSERT INTO CLAIMS (CLAIM_ID, POLICY_NUM, CUSTOMER_ID, STATUS, CALL_RECORDS)
            VALUES ( 'AB0033789',
                     'GL0000336512',
                     '09736814',
                     'CLOSED',
                     SYSTOOLS.JSON2BSON('{"calls": [ {"dateOfCall": "2014-02-26", "associate": "Steven Barnes",
                                          "conversationNotes": "Customer provided details of accident and witness
                                          contact information.  Stated that her local agent was unavailable."}  ],
                                          "satisfactionSurveyResult":"needs improvement"  }'
                                        ) 
                     );