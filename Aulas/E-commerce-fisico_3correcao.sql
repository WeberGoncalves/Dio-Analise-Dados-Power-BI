CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tabela de Clientes
create table clients (
	idClient int auto_increment primary key, -- ID do cliente
	Fname varchar(10), -- Primeiro nome
	Minit char(3), -- Inicial do meio
	Lname varchar(20), -- Sobrenome
	CPF char(11) not null, -- CPF do cliente
	Address varchar(30), -- Endereço
	constraint unique_cpf_client unique (CPF) -- CPF único
);

-- Tabela de Produtos
create table product (
	idProduct int auto_increment primary key, -- ID do produto
	Pname varchar(10) not null, -- Nome do produto
	classification_kids bool default false, -- Indica se é para crianças
	category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis') not null, -- Categoria
	evaluation float default 0, -- Avaliação do produto
	size varchar(10) -- Dimensão do produto
);

-- Tabela de Pagamentos
create table payments (
	idPayment int auto_increment primary key, -- ID do pagamento
	idClient int, -- ID do cliente
	typePayment enum('Boleto','Cartao','Dois cartoes'), -- Tipo de pagamento
	limitAvailable float, -- Limite disponível
	constraint fk_payments_client foreign key (idClient) references clients(idClient) -- FK para cliente
);

-- Tabela de Pedidos
create table orders (
	idOrder int auto_increment primary key, -- ID do pedido
	idOrderClient int, -- ID do cliente que fez o pedido
	orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento', -- Status do pedido
	orderDescription varchar(255), -- Descrição do pedido
	sendValue float default 10, -- Valor do frete
	paymentCash boolean default false, -- Indica se foi pago em dinheiro
	constraint fk_orders_client foreign key (idOrderClient) references clients(idClient) -- FK para cliente
);

-- Tabela de Estoque
create table productStorage (
	idProdStorage int auto_increment primary key, -- ID do estoque
	storageLocation varchar(255), -- Localização física
	quantity int default 0 -- Quantidade em estoque
);

-- Tabela de Fornecedores
create table supplier (
	idSupplier int auto_increment primary key, -- ID do fornecedor
	SocialName varchar(255) not null, -- Razão social
	CNPJ char(15) not null, -- CNPJ
	contact char(11) not null, -- Contato
	constraint unique_supplier unique (CNPJ) -- CNPJ único
);

-- Tabela de Vendedores
create table seller (
	idSeller int auto_increment primary key, -- ID do vendedor
	SocialName varchar(255) not null, -- Razão social
	AbstName varchar(255), -- Nome fantasia
	CNPJ char(15), -- CNPJ
	CPF char(11), -- CPF
	location varchar(255), -- Localização
	contact char(11) not null, -- Contato
	constraint unique_cnpj_seller unique (CNPJ), -- CNPJ único
	constraint unique_cpf_seller unique (CPF) -- CPF único
);

-- Relação Produto-Vendedor
create table productSeller (
	idPseller int, -- ID do vendedor
	idPproduct int, -- ID do produto
	prodQuantity int default 1, -- Quantidade disponível
	primary key (idPseller, idPproduct),
	constraint fk_productSeller_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_productSeller_product foreign key (idPproduct) references product(idProduct)
);

-- Relação Produto-Pedido
create table productOrder (
	idPOproduct int, -- ID do produto
	idPOorder int, -- ID do pedido
	poQuantity int default 1, -- Quantidade no pedido
	poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel', -- Status do produto
	primary key (idPOproduct, idPOorder),
	constraint fk_productOrder_product foreign key (idPOproduct) references product(idProduct),
	constraint fk_productOrder_order foreign key (idPOorder) references orders(idOrder)
);

-- Localização de Produtos no Estoque
create table storageLocation (
	idLproduct int, -- ID do produto
	idLstorage int, -- ID do estoque
	location varchar(255) not null, -- Localização específica
	primary key (idLproduct, idLstorage),
	constraint fk_storageLocation_product foreign key (idLproduct) references product(idProduct),
	constraint fk_storageLocation_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- Relação Produto-Fornecedor
create table productSupplier (
	idPsSupplier int, -- ID do fornecedor
	idPsProduct int, -- ID do produto
	quantity int not null, -- Quantidade fornecida
	primary key (idPsSupplier, idPsProduct),
	constraint fk_productSupplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_productSupplier_product foreign key (idPsProduct) references product(idProduct)
);

-- inserçao de dados
USE ecommerce;

-- Inserir 8 clientes
INSERT INTO clients (Fname, Minit, Lname, CPF, Address) VALUES
('Ana', 'M', 'Silva', '11111111111', 'Rua A, 100'),
('Bruno', 'C', 'Oliveira', '22222222222', 'Rua B, 200'),
('Carla', 'D', 'Souza', '33333333333', 'Rua C, 300'),
('Daniel', 'E', 'Lima', '44444444444', 'Rua D, 400'),
('Elaine', 'F', 'Torres', '55555555555', 'Rua E, 500'),
('Felipe', 'G', 'Rocha', '66666666666', 'Rua F, 600'),
('Gabriela', 'H', 'Costa', '77777777777', 'Rua G, 700'),
('Henrique', 'I', 'Mendes', '88888888888', 'Rua H, 800');

-- Inserir produtos
INSERT INTO product (Pname, classification_kids, category, evaluation, size) VALUES
('Celular', false, 'Eletronico', 4.5, '15cm'),
('Camiseta', false, 'Vestimenta', 4.2, 'M'),
('Boneco', true, 'Brinquedos', 4.8, '30cm'),
('Sofá', false, 'Moveis', 4.0, '2m'),
('Chocolate', false, 'Alimentos', 4.9, '100g');

-- Inserir fornecedores
INSERT INTO supplier (SocialName, CNPJ, contact) VALUES
('Tech Distribuidora', '12345678000101', '11999999999'),
('Moda Brasil', '22345678000102', '11988888888'),
('Brinquedos Alegria', '32345678000103', '11977777777');

-- Inserir vendedores
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact) VALUES
('Vendas Eletrônicas', 'VendeTech', '42345678000104', '11111111111', 'São Paulo', '11966666666'),
('Moda Express', 'ModaX', '52345678000105', '22222222222', 'Rio de Janeiro', '11955555555');

-- Relacionar produtos com vendedores
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) VALUES
(1, 1, 10),
(1, 5, 20),
(2, 2, 15),
(2, 3, 25);

-- Inserir estoque
INSERT INTO productStorage (storageLocation, quantity) VALUES
('Galpão Central', 100),
('Depósito RJ', 50);

-- Relacionar produtos com estoque
INSERT INTO storageLocation (idLproduct, idLstorage, location) VALUES
(1, 1, 'Prateleira A'),
(2, 2, 'Prateleira B'),
(3, 1, 'Prateleira C');

-- Relacionar produtos com fornecedores
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
(1, 1, 50),
(2, 2, 30),
(3, 3, 40);

-- Inserir pedidos para os 8 clientes
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES
(1, 'Confirmado', 'Compra de celular', 15.0, false),
(2, 'Em processamento', 'Compra de camiseta', 10.0, true),
(3, 'Confirmado', 'Compra de boneco', 12.0, false),
(4, 'Cancelado', 'Compra de sofá', 25.0, false),
(5, 'Confirmado', 'Compra de chocolate', 8.0, true),
(6, 'Em processamento', 'Compra de celular e camiseta', 18.0, false),
(7, 'Confirmado', 'Compra de brinquedo e chocolate', 20.0, true),
(8, 'Confirmado', 'Compra de sofá e camiseta', 30.0, false);

-- Relacionar produtos com pedidos
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
(1, 1, 1, 'Disponivel'),
(2, 2, 2, 'Disponivel'),
(3, 3, 1, 'Disponivel'),
(4, 4, 1, 'Sem estoque'),
(5, 5, 3, 'Disponivel'),
(1, 6, 1, 'Disponivel'),
(2, 6, 1, 'Disponivel'),
(3, 7, 1, 'Disponivel'),
(5, 7, 1, 'Disponivel'),
(4, 8, 1, 'Disponivel'),
(2, 8, 2, 'Disponivel');

-- Inserir pagamentos
INSERT INTO payments (idClient, typePayment, limitAvailable) VALUES
(1, 'Cartao', 3000.00),
(2, 'Boleto', 500.00),
(3, 'Cartao', 1500.00),
(4, 'Dois cartoes', 2000.00),
(5, 'Pix', 800.00),
(6, 'Cartao', 2500.00),
(7, 'Boleto', 600.00),
(8, 'Cartao', 1800.00);
--corrigindo o erro
ALTER TABLE payments MODIFY typePayment ENUM('Boleto','Cartao','Dois cartoes','Pix');

