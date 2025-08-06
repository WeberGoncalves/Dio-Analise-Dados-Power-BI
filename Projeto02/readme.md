<h1>
    <a href="https://www.dio.me/">
     <img align="center" width="40px" src="https://hermes.digitalinnovation.one/assets/diome/logo-minimized.png"></a>
    <span>Projeto 02 - Oficina Mecânica</span>
</h1>

## Objetivo
Praticar o Desenvolvimento de Banco de Dados com Diagrama esquema conceitual do Oficina Mecânica.


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
      <td>Planejando como Desenvolver</td>
    </tr>
    <tr>
      <td>02</td>
      <td>Entendendo o Cenário do Oficina Mecânica</td>
    </tr>
    <tr>
      <td>03</td>
      <td>Levantamento das Entidades, atributos e Relacionamentos</td>  
    </tr>
    <tr>
      <td>04</td>
      <td>Desenvolvendo Entidades, atributos e Relacionamentos com Workbench</td>    
    </tr>
  </tbody>
</table>

---
## Desafio do Projeto da DIO
Criar o esquema conceitual  da narrativa fornecida você será capaz de criar todas as entidades, relacionamentos e atributos. <br>

### Entidades, atributos
Entidades e Atributos
| Entidades| Atributos |
|----------|--------|
|**Cliente** |id_cliente(PK); nome; telefone; email; endereço|
|**Veículo** |id_veiculo(PK); placa; modelo; ano; id_cliente (FK)|
|**Mecânico** |
id_mecanico (PK)
nome
endereço
especialidade<br>
|**Equipe** |
id_equipe (PK)
nome<br>
|**Equipe_Mecanico** |
id_equipe (FK)
id_mecanico (FK)<br>
|**Ordem_de_Serviço** |id_os(PK); data_emissao; data_entrega; valor_total; status; id_veiculo(FK);id_equipe (FK)|
|**Serviço** |id_servico(PK); descricao; valor_mao_obra|
|**OS_Serviço**|id_os(FK); id_servico(FK); quantidade; valor_total_servico|
|**Peça** |id_peca(PK); nome; valor_unitario|
|**OS_Peca**|id_os(FK); id_peca(FK); quantidade; valor_total_peca|

### Relacionamentos

Um cliente pode ter vários veículos.
Um veículo está vinculado a uma única OS ativa por vez.
Cada OS é atribuída a uma única equipe.
Uma equipe é composta por vários mecânicos, e um mecânico pode participar de mais de uma equipe.
Uma OS contém vários serviços e pode utilizar várias peças.
Cada serviço tem um valor definido por tabela de referência de mão de obra.

> [!IMPORTANT]   
> *Confira a baixo como ficou o esquema conceitual em formato PNG*

### Esquema conceitual
![weber](/Projeto02/Projeto02_OficinaMecanica_ER.png)


## Ferramentas
[![GitHub](https://img.shields.io/badge/GitHub-000?style=for-the-badge&logo=github&logoColor=30A3DC)](https://docs.github.com/) <br>
![weber](/img/workbench_.png)**Workbenck**
---# Dio-Análise-Dados-Power-BI
