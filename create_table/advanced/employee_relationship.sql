CREATE TABLE employee_relationship (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    manager_id INT
);
  
INSERT INTO employee_relationship (
    employee_id,
    manager_id
)
VALUES
    (1, 22),
    (2, 22),
    (3, 2),
    (4, 2),
    (5, 1),
    (6, 1),
    (7, 2),
    (8, 22),
    (9, 22),
    (10, 9),
    (11, 8),
    (12, 2),
    (13, 22),
    (14, 3),
    (15, 13),
    (16, 8),
    (17, 13),
    (18, 1),
    (19, 17),
    (20, 19),
    (21, 11),
    (22, 19),
    (23, 6),
    (24, 13),
    (25, 9),
    (26, 9),
    (27, 6),
    (28, 16),
    (29, 6),
    (30, 3),
    (31, 6),
    (32, 6),
    (33, 16),
    (34, 13),
    (35, 13),
    (36, 13),
    (37, 3),
    (38, 18),
    (39, 9),
    (40, 16),
    (41, 9),
    (42, 9),
    (43, 18),
    (44, 3),
    (45, 3),
    (46, 16),
    (47, 13),
    (48, 9),
    (49, 9),
    (50, 3)