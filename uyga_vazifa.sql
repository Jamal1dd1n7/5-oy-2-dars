-- 1-misol
DROP TABLE IF EXISTS departments CASCADE; -- CASCADE bu yerda biror bir jadval o`chirilganda, shu jadvalga ulanga jadvalga ya`ni chetki jadvalga
-- o`zgartirish kirtimaslik uchun ishlatildi. Ya`ni departaments jadvali o`chirilganda unga ulanga chetki jadvalga ta`sir o`tkazmaslik uchun ishlatilgan
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS tasks CASCADE;

CREATE TABLE IF NOT EXISTS departments (
    id SERIAL PRIMARY KEY,          
    name TEXT NOT NULL,            
    location TEXT NOT NULL          
);

CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,        
    name TEXT NOT NULL,            
    position TEXT NOT NULL,        
    department_id INTEGER,         
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Departments(id)
);

CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,          
    title TEXT NOT NULL,            
    department_id INTEGER,          
    CONSTRAINT fk_department_proj FOREIGN KEY (department_id) REFERENCES Departments(id)
);

CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,          
    description TEXT NOT NULL,      
    project_id INTEGER,             
    employee_id INTEGER,           
    CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES Projects(id),
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES Employees(id)
);

INSERT INTO departments(id, name, location) VALUES
(1, 'Hall', 'security'),
(2, 'Kitchen', 'cafeteria');

INSERT INTO employees(id, name, position, department_id) VALUES
(1, 'Jamoliddin', 'Chef', 2),
(2, 'Anna', 'Security Officer', 1);

INSERT INTO projects(id, title, department_id) VALUES
(1, 'Catering Upgrade', 2),
(2, 'Safety Enhancement', 1);

INSERT INTO tasks(id, description, project_id, employee_id) VALUES
(1, 'Prepare lunch menu', 1, 1),
(2, 'Monitor entrance', 2, 2);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM tasks;

-- 2-misol
ALTER TABLE employees
ADD COLUMN email TEXT;

UPDATE employees
SET email = name || id || '@gmail.com'; -- bu yerda emailga defult xolatda ya`ni email kiritilmaganda, kiritilgan ischining name va idisidan foydalanib email yaratib qo`yadi.
-- bu yerda ikki chiziq name va id ini birlashtirish uchun ishlatilgan

ALTER TABLE tasks
ALTER COLUMN description TYPE VARCHAR(255);

SELECT * FROM employees;
SELECT * FROM tasks;

-- 3-misol
UPDATE employees SET position = 'Senior developer' WHERE id = 1;
UPDATE Projects SET title = 'New Project Title' WHERE id = 2;

SELECT * FROM employees;
SELECT * FROM tasks;

-- 4-misol
ALTER TABLE tasks
DROP CONSTRAINT IF EXISTS fk_project,
ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES Projects(id) ON DELETE CASCADE;

DELETE FROM projects
WHERE id = 3;

ALTER TABLE tasks
DROP CONSTRAINT IF EXISTS fk_employee,
ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES Employees(id) ON DELETE SET NULL;

DELETE FROM Employees
WHERE id = 4;


SELECT * FROM employees;
SELECT * FROM tasks;
SELECT * FROM projects;
SELECT * FROM departments;