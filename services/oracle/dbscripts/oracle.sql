-- Create table with JSON column
CREATE TABLE json_store (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data CLOB CHECK (data IS JSON)
);

-- Procedure to insert 1 million rows
CREATE OR REPLACE PROCEDURE insert_json_data AS
    v_i NUMBER := 0;
BEGIN
    WHILE v_i < 1000000 LOOP
        INSERT INTO json_store (data) VALUES (
            JSON_OBJECT(
                'id' VALUE v_i,
                'user' VALUE JSON_OBJECT(
                    'name' VALUE 'User_' || v_i,
                    'age' VALUE TRUNC(DBMS_RANDOM.VALUE(20, 70)),
                    'address' VALUE JSON_OBJECT(
                        'street' VALUE 'Street_' || v_i,
                        'city' VALUE 'City_' || MOD(v_i, 100),
                        'country' VALUE 'Country_' || MOD(v_i, 50),
                        'coordinates' VALUE JSON_OBJECT(
                            'lat' VALUE (DBMS_RANDOM.VALUE(-90, 90)),
                            'lng' VALUE (DBMS_RANDOM.VALUE(-180, 180))
                        )
                    ),
                    'contacts' VALUE JSON_ARRAY(
                        JSON_OBJECT('type' VALUE 'email', 'value' VALUE 'user_' || v_i || '@example.com'),
                        JSON_OBJECT('type' VALUE 'phone', 'value' VALUE '123456789' || MOD(v_i, 10))
                    )
                )
            )
        );
        v_i := v_i + 1;
    END LOOP;
    COMMIT;
END insert_json_data;
/

-- Execute the procedure to insert data
BEGIN
    insert_json_data;
END;
/
