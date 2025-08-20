CREATE SCHEMA IF NOT EXISTS company;
USE company;

CREATE TABLE employee (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    PRIMARY KEY (Ssn)
) ENGINE=InnoDB;

CREATE TABLE department (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE,
    PRIMARY KEY (Dnumber),
    UNIQUE (Dname),
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
) ENGINE=InnoDB;

CREATE TABLE dept_locations (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
) ENGINE=InnoDB;

CREATE TABLE project (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnumber INT NOT NULL,
    PRIMARY KEY (Pnumber),
    UNIQUE (Pname),
    FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
) ENGINE=InnoDB;

CREATE TABLE works_on (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES project(Pnumber)
) ENGINE=InnoDB;

CREATE TABLE dependent (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR(1), -- F ou M
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn)
) ENGINE=InnoDB;
 
 ---pupulando
 -- Inserindo funcionários (employee)

 INSERT INTO employee VALUES
('Alice', 'M', 'Johnson', '111111111', '1985-04-12', '123 Maple St', 'F', 6000.00, NULL, 1),
('Bob', 'J', 'Smith', '222222222', '1978-09-23', '456 Oak St', 'M', 7500.00, '111111111', 2),
('Carol', 'A', 'Davis', '333333333', '1990-02-17', '789 Pine St', 'F', 5800.00, '111111111', 1),
('David', 'B', 'Miller', '444444444', '1982-11-05', '321 Birch St', 'M', 7200.00, '222222222', 3),
('Eva', 'C', 'Wilson', '555555555', '1988-06-30', '654 Cedar St', 'F', 6700.00, NULL, 2),
('Frank', 'D', 'Moore', '666666666', '1995-01-20', '987 Elm St', 'M', 4900.00, '222222222', 3),
('Grace', 'E', 'Taylor', '777777777', '1993-08-14', '159 Spruce St', 'F', 5300.00, '111111111', 1),
('Henry', 'F', 'Anderson', '888888888', '1987-03-09', '753 Walnut St', 'M', 6100.00, '555555555', 2),
('Ivy', 'G', 'Thomas', '999999999', '1991-12-01', '852 Chestnut St', 'F', 5600.00, '555555555', 3),
('Jack', 'H', 'White', '000000000', '1984-07-27', '951 Poplar St', 'M', 6800.00, '555555555', 2);
 
 INSERT INTO department VALUES
('HR', 1, '111111111', '2015-01-01'),
('IT', 2, '555555555', '2016-03-15'),
('Finance', 3, '222222222', '2017-06-20');
 
 INSERT INTO dept_locations VALUES
(1, 'New York'),
(2, 'San Francisco'),
(3, 'Chicago'),
(2, 'Austin');
 
 INSERT INTO project VALUES
('Payroll', 101, 'New York', 1),
('Network', 102, 'San Francisco', 2),
('Audit', 103, 'Chicago', 3),
('AppDev', 104, 'Austin', 2),
('Strategy', 105, 'New York', 1);
 
 INSERT INTO works_on VALUES
('111111111', 101, 20.5),
('222222222', 102, 35.0),
('333333333', 101, 15.0),
('444444444', 103, 40.0),
('555555555', 102, 25.0),
('666666666', 104, 30.0),
('777777777', 105, 18.0),
('888888888', 102, 22.5),
('999999999', 103, 19.0),
('000000000', 105, 27.0);
 
 INSERT INTO dependent VALUES
('111111111', 'Liam', 'M', '2010-05-12', 'Son'),
('222222222', 'Emma', 'F', '2012-08-20', 'Daughter'),
('555555555', 'Noah', 'M', '2008-03-30', 'Son'),
('777777777', 'Olivia', 'F', '2015-09-10', 'Daughter'),
('000000000', 'Sophia', 'F', '2013-11-25', 'Daughter');

-- 1. Listar todos os funcionários com seus departamentos
SELECT e.Fname, e.Lname, d.Dname
FROM employee e
JOIN department d ON e.Dno = d.Dnumber;

-- 2. Mostrar os projetos e os locais onde estão sendo realizados
SELECT Pname, Plocation
FROM project;

-- 3. Verificar os funcionários que trabalham em mais de um projeto
SELECT Essn, COUNT(Pno) AS num_projetos
FROM works_on
GROUP BY Essn
HAVING COUNT(Pno) > 1;

-- 4. Calcular o salário médio por departamento
SELECT d.Dname, AVG(e.Salary) AS salario_medio
FROM employee e
JOIN department d ON e.Dno = d.Dnumber
GROUP BY d.Dname;

-- 5. Listar os supervisores e seus subordinados
SELECT s.Fname AS Supervisor, e.Fname AS Subordinado
FROM employee e
JOIN employee s ON e.Super_ssn = s.Ssn;

-- 6. Mostrar os dependentes de cada funcionário
SELECT e.Fname, e.Lname, d.Dependent_name, d.Relationship
FROM employee e
JOIN dependent d ON e.Ssn = d.Essn;

-- 7. Projetos com mais de 100 horas totais trabalhadas
SELECT p.Pname, SUM(w.Hours) AS total_horas
FROM project p
JOIN works_on w ON p.Pnumber = w.Pno
GROUP BY p.Pname
HAVING SUM(w.Hours) > 100;

-- 8. Funcionários que não têm dependentes
SELECT e.Fname, e.Lname
FROM employee e
LEFT JOIN dependent d ON e.Ssn = d.Essn
WHERE d.Essn IS NULL;

-- 9. Mostrar os gerentes e a data que começaram a gerenciar
SELECT e.Fname, e.Lname, d.Dname, d.Mgr_start_date
FROM department d
JOIN employee e ON d.Mgr_ssn = e.Ssn;

-- 10. Total de horas trabalhadas por funcionário em todos os projetos
SELECT e.Fname, e.Lname, SUM(w.Hours) AS horas_totais
FROM employee e
JOIN works_on w ON e.Ssn = w.Essn
GROUP BY e.Ssn;