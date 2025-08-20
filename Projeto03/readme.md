<h1>
    <a href="https://www.dio.me/">
     <img align="center" width="40px" src="https://hermes.digitalinnovation.one/assets/diome/logo-minimized.png"></a>
    <span>Projeto 03 - E-commerce</span>
</h1>

## Objetivo
Define uma estrutura de um banco de dados chamado ecommerce, voltado para gerenciar operações de uma loja virtual.
 Para comprir esse objetivo, foi criado tabelas e relacionamentos que cobrem os principais aspectos de um sistema de comércio eletrônico. 

## Percurso
<table>
  <thead>
    <tr align="left">
      <th>Nº</th>
      <th>Etapas</th>
    </tr>
  </thead>
  <tbody align="left">
    <tr>
      <td>01</td>
      <td>Desenvolver o Diagrama de entidade e relacionamentos</td>
    </tr>
    <tr>
      <td>02</td>
      <td>Desenvolver o modelo Físico, estrutura BD com as tabelas</td>
    </tr>
    <tr>
      <td>03</td>
      <td>Popular as tabelas no MySQL</td>  
    </tr>
    <tr>
      <td>04</td>
      <td>Realizar algumas Consultas ou queries</td>    
    </tr>
  </tbody>
</table>

---
## 🎯Desafio do Projeto da DIO
realize a criação do Script SQL para criação do esquema do banco de dados. Posteriormente, realize a persistência de dados para realização de testes. Especifique ainda queries mais complexas dos que apresentadas durante a explicação do desafio. Sendo assim, crie queries SQL com as cláusulas:
 <br>
Recuperações simples com SELECT Statement<br>
Filtros com WHERE Statement<br>
Crie expressões para gerar atributos derivados<br>
Defina ordenações dos dados com ORDER BY<br>
Condições de filtros aos grupos – HAVING Statement<br>
Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados.<br>
### Perguntas para ser respondidas pelas queries SQL:

  **Quantos pedidos foram feitos por cada cliente?<br>
  Algum vendedor também é fornecedor?<br>
  Relação de produtos fornecedores e estoques;<br>
  Relação de nomes dos fornecedores e nomes dos produtos;<br>**



> [!IMPORTANT]   
> *Confira a baixo como ficou Diagrama ER em formato PNG*

### Diagrama de Entidade Relacionameno

![weber](/Projeto03/E-commecer_Projeto-final.png)

### **Script da estrutura do banco de Dados**

```yaml annotate
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tabela de Clientes
create table clients (
idClient int auto_increment primary key, 
Fname varchar(10), 
Minit char(3), 
Lname varchar(20), 
CPF char(11) not null, 
Address varchar(30), 
constraint unique_cpf_client unique (CPF) 
);

-- Tabela de Produtos
create table product (
idProduct int auto_increment primary key, 
Pname varchar(10) not null, 
classification_kids bool default false, 
category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis') not null, 
evaluation float default 0, 
size varchar(10) 
);

-- Tabela de Pagamentos
create table payments (
idPayment int auto_increment primary key, 
idClient int, -- ID do cliente
typePayment enum('Boleto','Cartao','Dois cartoes'),
limitAvailable float,
constraint fk_payments_client foreign key (idClient) references clients(idClient) 
);

-- Tabela de Pedidos
create table orders (
idOrder int auto_increment primary key,
idOrderClient int, -- ID do cliente que fez o pedido
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
CNPJ char(15) not null, 
contact char(11) not null, 
constraint unique_supplier unique (CNPJ) 
);

-- Tabela de Vendedores
create table seller (
idSeller int auto_increment primary key, 
SocialName varchar(255) not null, 
AbstName varchar(255),
CNPJ char(15), 
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
```
### **Inserindo Dados no Banco**
```yaml annotate
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

ALTER TABLE payments MODIFY typePayment ENUM('Boleto','Cartao','Dois cartoes','Pix');
```
### Consultas ao Banco de dados
**Query 01**
```yaml annotate
--Listar os clientes que fizeram pedidos, mostrando o número de pedidos, o valor total estimado (frete + quantidade de produtos), e filtrar apenas aqueles que gastaram mais de R$100. Ordenar pelo valor total decrescente.

SELECT 
    c.idClient,
    CONCAT(c.Fname, ' ', c.Lname) AS fullName,
    COUNT(o.idOrder) AS totalOrders,
    SUM(o.sendValue + po.poQuantity * 20) AS estimatedTotalSpent -- suposição: cada produto custa R$20
FROM clients c
JOIN orders o ON c.idClient = o.idOrderClient
JOIN productOrder po ON o.idOrder = po.idPOorder
GROUP BY c.idClient
HAVING estimatedTotalSpent > 100
ORDER BY estimatedTotalSpent DESC;
```
**Imagem da consulta 01**

![weber](/Projeto03/quereis-01.png)

**Query 02**
```yaml annotate
-- Listar todos os vendedores cadastrados no sistema e mostrar quantos 
produtos cada um está vendendo.

SELECT 
    s.idSeller,
    s.SocialName,
    COUNT(ps.idPproduct) AS totalProducts
FROM seller s
JOIN productSeller ps ON s.idSeller = ps.idPseller
GROUP BY s.idSeller;
```
**Imagem da consulta 02**

![weber](/Projeto03/quereis-02.png)

**Query 03**
```yaml annotate
--Quantos pedidos foram feitos por cada cliente?

SELECT 
    c.idClient,
    CONCAT(c.Fname, ' ', c.Lname) AS fullName,
    COUNT(o.idOrder) AS totalOrders
FROM clients c
JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient;
```
**Imagem da consulta 03**

![weber](/Projeto03/quereis-03.png)


**Query 04**
```yaml annotate
--Algum vendedor também é fornecedor?

SELECT 
    s.idSeller,
    s.SocialName AS sellerName,
    f.idSupplier,
    f.SocialName AS supplierName,
    s.CNPJ
FROM seller s
INNER JOIN supplier f ON s.CNPJ = f.CNPJ;
```
**Imagem da consulta 04**

![weber](/Projeto03/quereis-04.png)


**Query 05**
```yaml annotate
--Relação de produtos fornecedores e estoques;

SELECT 
    p.idProduct,
    p.Pname AS productName,
    s.SocialName AS supplierName,
    ps.quantity AS suppliedQuantity,
    st.storageLocation AS stockLocation,
    sl.location AS specificLocation
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN supplier s ON ps.idPsSupplier = s.idSupplier
JOIN storageLocation sl ON p.idProduct = sl.idLproduct
JOIN productStorage st ON sl.idLstorage = st.idProdStorage;
```
**Imagem da consulta 05**

![weber](/Projeto03/quereis-05.png)


**Query 06**
```yaml annotate
--Relação de nomes dos fornecedores e nomes dos produtos;

SELECT 
    s.SocialName AS supplierName,
    p.Pname AS productName
FROM supplier s
JOIN productSupplier ps ON s.idSupplier = ps.idPsSupplier
JOIN product p ON ps.idPsProduct = p.idProduct;
```
**Imagem da consulta 06**

![weber](/Projeto03/quereis-06.png)


## Ferramentas
[![GitHub](https://img.shields.io/badge/GitHub-000?style=for-the-badge&logo=github&logoColor=30A3DC)](https://docs.github.com/) <br>
![weber](/img/workbench_.png)**Workbenck**<br>

---# Dio-Análise-Dados-Power-BI
