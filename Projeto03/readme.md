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
Recuperações simples com SELECT Statement
Filtros com WHERE Statement
Crie expressões para gerar atributos derivados
Defina ordenações dos dados com ORDER BY
Condições de filtros aos grupos – HAVING Statement
Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados.
### Algumas das perguntas que podes fazer para embasar as queries SQL:

  Quantos pedidos foram feitos por cada cliente?
  Algum vendedor também é fornecedor?
  Relação de produtos fornecedores e estoques;
  Relação de nomes dos fornecedores e nomes dos produtos;

### Entidades e Atributos

| Entidades| Atributos |
|----------|--------------------------------------------------|
|**Cliente** |id_cliente(PK); nome; telefone; email; endereço|
|**Veículo** |id_veiculo(PK); placa; modelo; ano; id_cliente (FK)|
|**Mecânico** |id_mecanico(PK); nome; endereço; especialidade|
|**Equipe** |id_equipe(PK); nome|
|**Equipe_Mecanico** |id_equipe(FK); id_mecanico(FK)|
|**Ordem_de_Serviço** |id_os(PK); data_emissao; data_entrega; valor_total; status; id_veiculo(FK);id_equipe (FK)|
|**Serviço** |id_servico(PK); descricao; valor_mao_obra|
|**OS_Serviço**|id_os(FK); id_servico(FK); quantidade; valor_total_servico|
|**Peça** |id_peca(PK); nome; valor_unitario|
|**OS_Peca**|id_os(FK); id_peca(FK); quantidade; valor_total_peca|

### Relacionamentos

Um cliente pode ter vários veículos.<br>
Um veículo está vinculado a uma única OS ativa por vez.<br>
Cada OS é atribuída a uma única equipe.<br>
Uma equipe é composta por vários mecânicos, e um mecânico pode participar de mais de uma equipe.<br>
Uma OS contém vários serviços e pode utilizar várias peças.<br>
Cada serviço tem um valor definido por tabela de referência de mão de obra.

> [!IMPORTANT]   
> *Confira a baixo como ficou o esquema conceitual em formato PNG*

### 🛠️ Esquema Conceitual — Oficina Mecânica 🛠️

![weber](/Projeto02/Projeto02_OficinaMecanica_ER.png)


## Ferramentas
[![GitHub](https://img.shields.io/badge/GitHub-000?style=for-the-badge&logo=github&logoColor=30A3DC)](https://docs.github.com/) <br>
![weber](/img/workbench_.png)**Workbenck**<br>

---# Dio-Análise-Dados-Power-BI
