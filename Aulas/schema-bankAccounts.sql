-- explorando os comando ddl

select now() as Timestamp;

create database manipulation;
use manipulation;

CREATE TABLE bankAccounts (
	Id_account INT auto_increment PRIMARY KEY,
	Ag_num INT NOT NULL,
	Ac_num INT NOT NULL,
	Saldo FLOAT,
	CONSTRAINT identification_account_constraint UNIQUE (Ag_num, Ac_num)
);

alter table bankAccounts add LimiteCredito float
	not null default 500.00;
alter table bankAccounts add email varchar(60);
alter table bankAccounts drop email;
-- alter table nome_tabela modify column nome_atributo tipo_dados condicao;
-- alter table nome_tabela add constraint nome_constraint condicoes;

CREATE TABLE bankClient(
	Id_client INT auto_increment,
	ClientAccount INT,
	CPF CHAR(11) NOT NULL,
	RG CHAR(9) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Endereço VARCHAR(100) NOT NULL,
	Renda_mensal FLOAT,
	primary key (iD_Client, ClientAccount),
	CONSTRAINT fk_acconut_client foreign key (ClientAccount) REFERENCES bankAccounts(Id_account)
	ON UPDATE CASCADE
);

insert into bankClient values(1235,12345678913,123465789, 'Fulano','rua de la', 6500.6);
alter table bankClient add UFF char(2) not null default 'RJ';
update bankClient set UFF='MG' where Nome='fulano';

drop table bankClient;

CREATE TABLE bankTransactions(