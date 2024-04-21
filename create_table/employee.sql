CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT
);
  
INSERT INTO employee (
    first_name,
    last_name,
    department_id
)
VALUES
    ('Aaron','Coleman',2),
    ('Abby','Webster',3),
    ('Abigail','Rose',3),
    ('Adam','Knight',3),
    ('Alex','Hanson',2),
    ('Alexandra','Gilbert',2),
    ('Alexis','Jones',3),
    ('Allison','Barrett',4),
    ('Andrew','Mcgee',5),
    ('Asher','Williams',5),
    ('Audrey','Fisher',4),
    ('Austin','Brooks',3),
    ('Autumn','Fleming',6),
    ('Bailey','Lawrence',3),
    ('Blake','Mccarthy',6),
    ('Brandon','Palmer',4),
    ('Brayden','Bentley',6),
    ('Brooklyn','Miller',2),
    ('Cameron','Graham',6),
    ('Caroline','Farrell',2),
    ('Charlie','Russell',4),
    ('Chloe','Rowe',1),
    ('Claire','Holmes',2),
    ('Colton','Phillips',6),
    ('Connor','Acosta',5),
    ('Cooper','Seymour',5),
    ('Daniel','Moran',2),
    ('David','Weber',4),
    ('Dylan','Myers',2),
    ('Eli','Higgins',3),
    ('Elijah','Grant',2),
    ('Elizabeth','Ellis',2),
    ('Ellie','Bowman',4),
    ('Emma','May',6),
    ('Evan','Foster',6),
    ('Gabriella','Tucker',6),
    ('Gianna','Beattie',3),
    ('Grayson','Rodgers',2),
    ('Hailey','Quinn',5),
    ('Hannah','Page',4),
    ('Hayden','Strickland',5),
    ('Henry','Ingram',5),
    ('Hudson','Montgomery',2),
    ('Ian','Johnson',3),
    ('Isaac','Howell',3),
    ('Isabella','Carr',4),
    ('Jake','Alvarado',6),
    ('James','Doyle',5),
    ('Jasmine','Elliott',5),
    ('Jaxon','Thomson',3);
