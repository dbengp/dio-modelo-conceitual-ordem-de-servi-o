# dio-modelo-conceitual-ordem-de-serviço
## este projeto descreve o modelo conceitual de um sistema para gerenciar ordens de serviço, com foco em produtos, fornecedores e estoque. 

### Descrição do Projeto Conceitual
 - O esquema conceitual apresentado é composto pelas seguintes entidades, atributos e relacionamentos:

**Entidades:**

* **Cliente:** Representa os clientes que solicitam as ordens de serviço.
    * Atributos:
        * `ID_Cliente` (PK): Identificador único do cliente (integer).
        * `Nome` (varchar(50)): Nome do cliente.
        * `Identificacao` (varchar(50)): Informação de identificação do cliente (CPF/CNPJ).
        * `Endereco` (varchar(50)): Endereço do cliente.
        * `Telefone` (varchar(50)): Telefone de contato do cliente.

* **Pedido:** Representa a ordem de serviço em si.
    * Atributos:
        * `ID_Pedido` (PK): Identificador único do pedido (integer).
        * `Descricao_Pedido` (varchar(100)): Descrição do serviço ou necessidade do pedido.
        * `Status_Pedido` (boolean): Status do pedido (ex: Aberto, Em Andamento, Concluído).

* **Fornecedor:** Representa as empresas que fornecem produtos.
    * Atributos:
        * `ID_Fornecedor` (PK): Identificador único do fornecedor (integer).
        * `Razao_Social` (varchar(50)): Razão social do fornecedor.

* **Produto:** Representa os produtos que podem ser utilizados nas ordens de serviço ou vendidos.
    * Atributos:
        * `ID_Produto` (PK): Identificador único do produto (integer).
        * `Categoria` (varchar(50)): Categoria do produto.
        * `Descricao` (varchar(100)): Descrição do produto.
        * `Valor` (varchar(50)): Valor unitário do produto.

* **Estoque:** Representa o estoque de produtos da oficina.
    * Atributos:
        * `ID_Estoque` (PK): Identificador único do registro de estoque (integer).
        * `Local` (varchar(50)): Localização do estoque.
        * `ehpratrimonial` (boolean): Supõe um predio que está no patrimônio, do contrário é locação.

* **Terceiro:** Representa vendedores terceirizados.
    * Atributos:
        * `ID_Terceiro` (PK): Identificador único do vendedor terceirizado (integer).
        * `Razao_Social` (varchar(50)): Razão social ou nome do vendedor terceirizado.
        * `Local` (varchar(50)): Local de atuação do vendedor terceirizado.
        * `ehfranquiado` (boolean): Supõe uma representação por franquia.

**Relacionamentos e Entidades de Ligação:**

* **Pedido -> Cliente:** Um `Pedido` é feito por um `Cliente`. (Um-para-muitos)
    * Atributo de Ligação (em `Pedido`): `ID_Cliente` (FK) referenciando `Cliente`.

* **Relacao de Produto / Pedido:** Representa os produtos incluídos em um pedido.
    * Atributos:
        * `Quantidade` (varchar(50)): Quantidade do produto no pedido.
        * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
        * `ID_Pedido` (FK): Chave estrangeira referenciando a entidade `Pedido`.
    * Chave Primária Composta: (`ID_Produto`, `ID_Pedido`)

* **Disponibilizando um Produto (Fornecedor -> Produto):** Representa os produtos que um fornecedor disponibiliza.
    * Atributos:
        * `ID_Fornecedor` (FK): Chave estrangeira referenciando a entidade `Fornecedor`.
        * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
    * Chave Primária Composta: (`ID_Fornecedor`, `ID_Produto`)

* **Produto has Estoque (Produto -> Estoque):** Representa a quantidade de um produto em um determinado local de estoque.
    * Atributos:
        * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
        * `ID_Estoque` (FK): Chave estrangeira referenciando a entidade `Estoque`.
        * `Quantidade` (integer): Quantidade do produto no estoque.
    * Chave Primária Composta: (`ID_Produto`, `ID_Estoque`)

* **Produtos por Vendedor (Terceiro) (Produto -> Terceiro Vendedor):** Representa os produtos vendidos por um vendedor terceirizado.
    * Atributos:
        * `ID_Terceiro_Vendedor` (FK): Chave estrangeira referenciando a entidade `Terceiro Vendedor`.
        * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
        * `Quantidade` (integer): Quantidade do produto vendida pelo vendedor.
    * Chave Primária Composta: (`ID_Terceiro_Vendedor`, `ID_Produto`)

**Observações:**

* Este modelo conceitual parece focar mais na gestão de produtos, fornecedores e estoque dentro do contexto de ordens de serviço.
* A entidade `Pedido` é bastante genérica em sua descrição. Em um sistema de oficina mecânica mais detalhado, ela poderia incluir informações como data de emissão, data de previsão, tipo de serviço, veículo associado, etc.
* A relação entre `Pedido` e `Produto` é explícita através da entidade de ligação `Relacao de Produto / Pedido`, permitindo que um pedido contenha múltiplos produtos com suas respectivas quantidades.
* As relações com `Fornecedor`, `Estoque` e `Terceiro Vendedor` indicam funcionalidades para gerenciar o suprimento, a disponibilidade e a venda de produtos.
