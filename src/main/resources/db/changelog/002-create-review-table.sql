CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    client_id INTEGER,
    name VARCHAR(255),
    message VARCHAR(1000)
);
--rollback DROP TABLE review; команда для отката этого changeset'а