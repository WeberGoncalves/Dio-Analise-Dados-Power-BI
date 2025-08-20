create database ecommerce;
use ecommerce;

-- Tabela de Clientes
create table clients (
	idClient int auto_increment primary key,
	Fname varchar(10),
	Minit char(3),
	Lname varchar(20),
	CPF char(11) not null,
	Address varchar(100),
	constraint unique_cpf_client unique (CPF)
);

-- Tabela de Produtos
create table product (
	idProduct int auto_increment primary key,
	Pname varchar(50) not null,
	classification_kids boolean default false,
	category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis') not null,
	evaluation float default 0,
	size varchar(20)
);

-- Tabela de Pagamentos
create table payments (
	idClient int,
	idPayment int auto_increment,
	typePayment enum('Boleto','Cartao','Dois cartoes'),
	limitAvailable float,
	primary key(idPayment),
	constraint fk_payment_client foreign key (idClient) references clients(idClient)
);

-- Tabela de Pedidos
create table orders (
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
	orderDescription varchar(255),
	sendValue float default 10,
	paymentCash boolean default false,
	constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

-- Tabela de Estoque
create table productStorage (
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantity int default 0
);

-- Tabela de Fornecedores
create table supplier (
	idSupplier int auto_increment primary key,
	SocialName varchar(255) not null,
	CNPJ char(14) not null,
	contact char(11) not null,
	constraint unique_supplier_cnpj unique (CNPJ)
);

-- Tabela de Vendedores
create table seller (
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
	AbstName varchar(255),
	CNPJ char(14),
	CPF char(11),
	location varchar(255),
	contact char(11) not null,
	constraint unique_cnpj_seller unique (CNPJ),
	constraint unique_cpf_seller unique (CPF)
);

-- Relação Produto-Vendedor
create table productSeller (
	idPseller int,
	idPproduct int,
	prodQuantity int default 1,
	primary key (idPseller, idPproduct),
	constraint fk_productSeller_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_productSeller_product foreign key (idPproduct) references product(idProduct)
);

-- Relação Produto-Pedido
create table productOrder (
	idPOproduct int,
	idPOorder int,
	poQuantity int default 1,
	poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
	primary key (idPOproduct, idPOorder),
	constraint fk_productOrder_product foreign key (idPOproduct) references product(idProduct),
	constraint fk_productOrder_order foreign key (idPOorder) references orders(idOrder)
);

-- Localização de Produtos no Estoque
create table storageLocation (
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_storageLocation_product foreign key (idLproduct) references product(idProduct),
	constraint fk_storageLocation_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- Relação Produto-Fornecedor
create table productSupplier (
	idPsSupplier int,
	idPsProduct int,
	quantity int not null,
	primary key (idPsSupplier, idPsProduct),
	constraint fk_productSupplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_productSupplier_product foreign key (idPsProduct) references product(idProduct)
);