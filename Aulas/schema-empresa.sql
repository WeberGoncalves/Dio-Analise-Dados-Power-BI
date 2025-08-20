

CREATE SCHEMA IF NOT EXISTS empresa;
USE empresa;

CREATE TABLE funcionario (
    Primeiro_Nome VARCHAR(15) NOT NULL,
    Inicial CHAR(1),
    Sobrenome VARCHAR(15) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Data_Nascimento DATE,
    Endereco VARCHAR(30),
    Sexo CHAR(1),
    Salario DECIMAL(10,2),
    CPF_Supervisor CHAR(11),
    Numero_Departamento INT NOT NULL,
    PRIMARY KEY (CPF)
) ENGINE=InnoDB;

CREATE TABLE departamento (
    Nome_Departamento VARCHAR(15) NOT NULL,
    Numero_Departamento INT NOT NULL,
    CPF_Gerente CHAR(11),
    Data_Inicio_Gerente DATE,
    PRIMARY KEY (Numero_Departamento),
    UNIQUE (Nome_Departamento),
    FOREIGN KEY (CPF_Gerente) REFERENCES funcionario(CPF)
) ENGINE=InnoDB;

CREATE TABLE locais_departamento (
    Numero_Departamento INT NOT NULL,
    Localizacao VARCHAR(15) NOT NULL,
    PRIMARY KEY (Numero_Departamento, Localizacao),
    FOREIGN KEY (Numero_Departamento) REFERENCES departamento(Numero_Departamento)
) ENGINE=InnoDB;

CREATE TABLE projeto (
    Nome_Projeto VARCHAR(15) NOT NULL,
    Numero_Projeto INT NOT NULL,
    Localizacao VARCHAR(15),
    Numero_Departamento INT NOT NULL,
    PRIMARY KEY (Numero_Projeto),
    UNIQUE (Nome_Projeto),
    FOREIGN KEY (Numero_Departamento) REFERENCES departamento(Numero_Departamento)
) ENGINE=InnoDB;

CREATE TABLE trabalha_em (
    CPF_Funcionario CHAR(11) NOT NULL,
    Numero_Projeto INT NOT NULL,
    Horas DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (CPF_Funcionario, Numero_Projeto),
    FOREIGN KEY (CPF_Funcionario) REFERENCES funcionario(CPF),
    FOREIGN KEY (Numero_Projeto) REFERENCES projeto(Numero_Projeto)
) ENGINE=InnoDB;

CREATE TABLE dependente (
    CPF_Funcionario CHAR(11) NOT NULL,
    Nome_Dependente VARCHAR(15) NOT NULL,
    Sexo CHAR(1), -- F ou M
    Data_Nascimento DATE,
    Relacao VARCHAR(8),
    PRIMARY KEY (CPF_Funcionario, Nome_Dependente),
    FOREIGN KEY (CPF_Funcionario) REFERENCES funcionario(CPF)
) ENGINE=InnoDB;

--------------------------------------------Populando as tabelas

INSERT INTO funcionario VALUES
('Ana', 'M', 'Silva', '12345678901', '1985-03-15', 'Rua A, 100', 'F', 5500.00, NULL, 1),
('Bruno', 'C', 'Oliveira', '23456789012', '1990-07-22', 'Rua B, 200', 'M', 6200.00, '12345678901', 2),
('Carla', 'L', 'Souza', '34567890123', '1988-11-05', 'Rua C, 300', 'F', 4800.00, '12345678901', 1),
('Daniel', 'R', 'Costa', '45678901234', '1992-01-30', 'Rua D, 400', 'M', 5100.00, '23456789012', 3),
('Eduarda', 'S', 'Pereira', '56789012345', '1983-06-18', 'Rua E, 500', 'F', 7300.00, NULL, 2),
('Felipe', 'T', 'Almeida', '67890123456', '1995-09-12', 'Rua F, 600', 'M', 4600.00, '23456789012', 3),
('Gabriela', 'U', 'Fernandes', '78901234567', '1987-04-25', 'Rua G, 700', 'F', 5200.00, '12345678901', 1),
('Henrique', 'V', 'Lima', '89012345678', '1993-12-08', 'Rua H, 800', 'M', 5800.00, '56789012345', 2),
('Isabela', 'W', 'Mendes', '90123456789', '1991-02-14', 'Rua I, 900', 'F', 4950.00, '56789012345', 3),
('João', 'X', 'Barros', '01234567890', '1989-10-03', 'Rua J, 1000', 'M', 6100.00, '56789012345', 2);

INSERT INTO departamento VALUES
('Recursos Humanos', 1, '12345678901', '2015-01-01'),
('TI', 2, '56789012345', '2016-03-15'),
('Financeiro', 3, '23456789012', '2017-06-20');

INSERT INTO locais_departamento VALUES
(1, 'Bahia'),
(2, 'São Paulo'),
(3, 'Rio de Janeiro'),
(2, 'Minas Gerais');

INSERT INTO projeto VALUES
('Sistema RH', 101, 'Bahia', 1),
('Infraestrutura TI', 102, 'São Paulo', 2),
('Auditoria Financeira', 103, 'Rio de Janeiro', 3),
('App Mobile', 104, 'Minas Gerais', 2),
('Planejamento Estratégico', 105, 'Bahia', 1);

INSERT INTO trabalha_em VALUES
('12345678901', 101, 20.5),
('23456789012', 102, 35.0),
('34567890123', 101, 15.0),
('45678901234', 103, 40.0),
('56789012345', 102, 25.0),
('67890123456', 104, 30.0),
('78901234567', 105, 18.0),
('89012345678', 102, 22.5),
('90123456789', 103, 19.0),
('01234567890', 105, 27.0);

INSERT INTO dependente VALUES
('12345678901', 'Lucas', 'M', '2010-05-12', 'Filho'),
('23456789012', 'Mariana', 'F', '2012-08-20', 'Filha'),
('56789012345', 'Carlos', 'M', '2008-03-30', 'Filho'),
('78901234567', 'Beatriz', 'F', '2015-09-10', 'Filha'),
('01234567890', 'Sofia', 'F', '2013-11-25', 'Filha');

---------------------queries / consultas
---1️ Listar todos os funcionários com seus departamentos

SELECT f.Primeiro_Nome, f.Sobrenome, d.Nome_Departamento
FROM funcionario f
JOIN departamento d ON f.Numero_Departamento = d.Numero_Departamento;

--2 Listar funcionários que têm dependentes

SELECT DISTINCT f.Primeiro_Nome, f.Sobrenome
FROM funcionario f
JOIN dependente d ON f.CPF = d.CPF_Funcionario;

--3️ Listar projetos e os funcionários que trabalham nele
SELECT p.Nome_Projeto, f.Primeiro_Nome, f.Sobrenome, t.Horas
FROM trabalha_em t
JOIN funcionario f ON t.CPF_Funcionario = f.CPF
JOIN projeto p ON t.Numero_Projeto = p.Numero_Projeto;

--4️ Calcular o total de horas trabalhadas por projeto
SELECT p.Nome_Projeto, SUM(t.Horas) AS Total_Horas
FROM trabalha_em t
JOIN projeto p ON t.Numero_Projeto = p.Numero_Projeto
GROUP BY p.Nome_Projeto;

--5️ Listar funcionários com salário acima de R$ 5.00
SELECT Primeiro_Nome, Sobrenome, Salario
FROM funcionario
WHERE Salario > 5000;

--6️ Listar os gerentes e seus departamento
SELECT f.Primeiro_Nome, f.Sobrenome, d.Nome_Departamento
FROM departamento d
JOIN funcionario f ON d.CPF_Gerente = f.CPF;

--7️ Contar o número de funcionários por departamento
SELECT d.Nome_Departamento, COUNT(f.CPF) AS Total_Funcionarios
FROM departamento d
JOIN funcionario f ON d.Numero_Departamento = f.Numero_Departamento
GROUP BY d.Nome_Departamento;

--8️ Listar os dependentes de cada funcionário
SELECT f.Primeiro_Nome, f.Sobrenome, d.Nome_Dependente, d.Relacao
FROM dependente d
JOIN funcionario f ON d.CPF_Funcionario = f.CPF;

--9️ Listar os projetos por departamento
SELECT d.Nome_Departamento, p.Nome_Projeto
FROM projeto p
JOIN departamento d ON p.Numero_Departamento = d.Numero_Departamento;

--10 Listar os locais onde cada departamento está presente
SELECT d.Nome_Departamento, l.Localizacao
FROM locais_departamento l
JOIN departamento d ON l.Numero_Departamento = d.Numero_Departamento;
