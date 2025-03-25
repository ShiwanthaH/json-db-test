CREATE TABLE json_store (
    id SERIAL PRIMARY KEY,
    data JSONB
);

DO $$ 
DECLARE 
    i INT := 0;
BEGIN
    WHILE i < 1000000 LOOP
        INSERT INTO json_store (data) VALUES (
            jsonb_build_object(
                'id', i,
                'user', jsonb_build_object(
                    'name', 'User_' || i,
                    'age', (random() * 50 + 20)::INT,
                    'address', jsonb_build_object(
                        'street', 'Street_' || i,
                        'city', 'City_' || (i % 100),
                        'country', 'Country_' || (i % 50),
                        'coordinates', jsonb_build_object(
                            'lat', (random() * 180 - 90),
                            'lng', (random() * 360 - 180)
                        )
                    ),
                    'contacts', jsonb_build_array(
                        jsonb_build_object('type', 'email', 'value', 'user_' || i || '@example.com'),
                        jsonb_build_object('type', 'phone', 'value', '123456789' || (i % 10))
                    )
                )
            )
        );
        i := i + 1;
    END LOOP;
END $$;
