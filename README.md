# dio-modelo-conceitual-ordem-de-serviço
## este projeto descreve o modelo conceitual de um sistema para gerenciar ordens de serviço, com foco em produtos, fornecedores e estoque. 

### Descrição do Projeto Conceitual de um e-commerce.
 - O esquema conceitual apresentado é composto pelas seguintes entidades, atributos e relacionamentos:

**Entidades:**

* **Cliente:** Representa os clientes que solicitam as ordens de serviço (Pessoa Física ou Jurídica).
    * Atributos:
        * `ID_Cliente` (PK): Identificador único do cliente (integer).
        * `Tipo_Cliente` (ENUM('PF', 'PJ')): Tipo do cliente (Pessoa Física ou Jurídica).
        * **Atributos para Pessoa Física (PF):**
            * `Nome_PF` (varchar(50)): Nome completo da pessoa física (nullable).
            * `CPF_PF` (varchar(14)): Cadastro de Pessoa Física (nullable, único se PF).
        * **Atributos para Pessoa Jurídica (PJ):**
            * `Razao_Social_PJ` (varchar(50)): Razão social da pessoa jurídica (nullable).
            * `CNPJ_PJ` (varchar(18)): Cadastro Nacional da Pessoa Jurídica (nullable, único se PJ).
        * `Endereco` (varchar(50)): Endereço do cliente.
        * `Telefone` (varchar(50)): Telefone de contato do cliente.
        * `Email` (varchar(50)): Email de contato do cliente (opcional).

* **Pedido:** Representa a ordem de serviço em si.
    * Atributos:
        * `ID_Pedido` (PK): Identificador único do pedido (integer).
        * `Data_Criacao` (TIMESTAMP): Data e hora de criação do pedido.
        * `Descricao_Pedido` (TEXT): Descrição detalhada do serviço ou necessidade do pedido.
        * `Status_Pedido` (ENUM('Aberto', 'Em Andamento', 'Concluído', 'Cancelado')): Status atual do pedido.
        * `ID_Cliente` (FK): Chave estrangeira referenciando a entidade `Cliente`.

* **Forma_Pagamento:** Representa as diferentes formas de pagamento aceitas.
    * Atributos:
        * `ID_Forma_Pagamento` (PK): Identificador único da forma de pagamento (integer).
        * `Descricao_Forma_Pagamento` (varchar(100)): Descrição da forma de pagamento (ex: Cartão de Crédito, Boleto, Pix).

* **Pagamento_Pedido:** Representa as formas de pagamento associadas a um pedido.
    * Atributos:
        * `ID_Pedido` (FK): Chave estrangeira referenciando a entidade `Pedido`.
        * `ID_Forma_Pagamento` (FK): Chave estrangeira referenciando a entidade `Forma_Pagamento`.
        * `Valor_Pago` (DECIMAL(10, 2)): Valor pago utilizando esta forma de pagamento.
    * Chave Primária Composta: (`ID_Pedido`, `ID_Forma_Pagamento`)

* **Entrega:** Representa os detalhes da entrega do pedido (se aplicável).
    * Atributos:
        * `ID_Entrega` (PK): Identificador único da entrega (integer).
        * `ID_Pedido` (FK): Chave estrangeira referenciando a entidade `Pedido`.
        * `Status_Entrega` (ENUM('Pendente', 'Em Trânsito', 'Entregue', 'Problemas')): Status da entrega.
        * `Codigo_Rastreio` (varchar(50)): Código de rastreamento da entrega (opcional).
        * `Data_Envio` (DATE): Data de envio do pedido (opcional).
        * `Data_Prevista_Entrega` (DATE): Data prevista para a entrega (opcional).
        * `Data_Entrega_Realizada` (DATE): Data em que a entrega foi realizada (opcional).

* **Fornecedor:** Representa as empresas que fornecem produtos.
    * Atributos:
        * `ID_Fornecedor` (PK): Identificador único do fornecedor (integer).
        * `Razao_Social` (varchar(50)): Razão social do fornecedor.
        * `CNPJ` (varchar(18)): CNPJ do fornecedor (opcional, mas útil).
        * `Contato` (varchar(50)): Nome do contato do fornecedor (opcional).
        * `Telefone` (varchar(50)): Telefone do fornecedor (opcional).
        * `Email` (varchar(50)): Email do fornecedor (opcional).

* **Produto:** Representa os produtos que podem ser utilizados nas ordens de serviço ou vendidos.
    * Atributos:
        * `ID_Produto` (PK): Identificador único do produto (integer).
        * `Nome_Produto` (varchar(50)): Nome do produto.
        * `Descricao_Produto` (TEXT): Descrição detalhada do produto.
        * `Categoria_Produto` (varchar(50)): Categoria do produto.
        * `Valor_Unitario` (DECIMAL(10, 2)): Valor unitário do produto.

* **Estoque:** Representa o estoque de produtos da oficina.
    * Atributos:
        * `ID_Estoque` (PK): Identificador único do registro de estoque (integer).
        * `Local_Estoque` (varchar(50)): Localização do estoque.

* **Terceiro_Vendedor:** Representa vendedores terceirizados (se aplicável).
    * Atributos:
        * `ID_Terceiro_Vendedor` (PK): Identificador único do vendedor terceirizado (integer).
        * `Nome_Vendedor` (varchar(50)): Nome do vendedor terceirizado.
        * `Contato_Vendedor` (varchar(50)): Informações de contato do vendedor (opcional).

**Relacionamentos e Entidades de Ligação:**

* **Pedido -> Cliente:** Um `Pedido` é feito por um `Cliente`. (Um-para-muitos)
    * Atributo de Ligação (em `Pedido`): `ID_Cliente` (FK) referenciando `Cliente`.

* **Pedido <-> Forma_Pagamento:** Um `Pedido` pode ter múltiplas `Forma_Pagamento` através da entidade de ligação `Pagamento_Pedido`. (Muitos-para-muitos)

* **Pedido -> Entrega:** Um `Pedido` pode ter uma `Entrega` associada. (Um-para-um)
    * Atributo de Ligação (em `Entrega`): `ID_Pedido` (FK) referenciando `Pedido`.

* **Pedido <-> Produto:** Um `Pedido` pode conter múltiplos `Produto` através da entidade de ligação `Item_Pedido`. (Muitos-para-muitos)
    * **Item_Pedido:** Representa os produtos incluídos em um pedido.
        * Atributos:
            * `ID_Pedido` (FK): Chave estrangeira referenciando a entidade `Pedido`.
            * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
            * `Quantidade` (integer): Quantidade do produto no pedido.
            * `Valor_Unitario_Item` (DECIMAL(10, 2)): Valor unitário do produto no item do pedido (pode variar do valor padrão).
            * `Subtotal_Item` (DECIMAL(10, 2)): Subtotal do item do pedido.
        * Chave Primária Composta: (`ID_Pedido`, `ID_Produto`)

* **Fornecedor <-> Produto:** Representa os produtos que um `Fornecedor` disponibiliza através da entidade de ligação `Fornecimento_Produto`. (Muitos-para-muitos)
    * **Fornecimento_Produto:**
        * Atributos:
            * `ID_Fornecedor` (FK): Chave estrangeira referenciando a entidade `Fornecedor`.
            * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
            * `Preco_Custo` (DECIMAL(10, 2)): Preço de custo do produto fornecido (opcional).
        * Chave Primária Composta: (`ID_Fornecedor`, `ID_Produto`)

* **Produto <-> Estoque:** Representa a quantidade de um `Produto` em um determinado `Estoque` através da entidade de ligação `Estoque_Produto`. (Muitos-para-muitos)
    * **Estoque_Produto:**
        * Atributos:
            * `ID_Estoque` (FK): Chave estrangeira referenciando a entidade `Estoque`.
            * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
            * `Quantidade_Estoque` (integer): Quantidade do produto no estoque.
        * Chave Primária Composta: (`ID_Estoque`, `ID_Produto`)

* **Terceiro_Vendedor <-> Produto:** Representa os produtos vendidos por um `Terceiro_Vendedor` através da entidade de ligação `Venda_Terceiro`. (Muitos-para-muitos)
    * **Venda_Terceiro:**
        * Atributos:
            * `ID_Terceiro_Vendedor` (FK): Chave estrangeira referenciando a entidade `Terceiro_Vendedor`.
            * `ID_Produto` (FK): Chave estrangeira referenciando a entidade `Produto`.
            * `Quantidade_Vendida` (integer): Quantidade do produto vendida pelo vendedor.
        * Chave Primária Composta: (`ID_Terceiro_Vendedor`, `ID_Produto`)
