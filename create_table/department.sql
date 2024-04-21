CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    department VARCHAR(100)
);

INSERT INTO department (
    department
)
VALUES
    ('Executive'),
    ('Finance'),
    ('Marketing'),
    ('Sales'),
    ('Human Resources'),
    ('Information Technology')
