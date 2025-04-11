# dio-modelo-conceitual-ordem-de-serviço
## este projeto descreve o modelo lógico de um sistema para gerenciar ordens de serviço, com foco em produtos, fornecedores e estoque.
- o script SQL <https://github.com/dbengp/dio-modelo-conceitual-ordem-de-servico/blob/8a7a16b5b564097a6a0ced43aa7b7c4651bf3d55/modelo-logico/bd_ordem_de_servico.sql> cria a estrutura lógica do banco de dados no PostgreSQL, refletindo o modelo conceitual fornecido. Para outros SGBDs, pequenas adaptações na sintaxe (principalmente em relação ao SERIAL e ao ENUM) podem ser necessárias.

## Descrição do projeto lógico:
### SGBD Escolhido: 
 - PostgreSQL foi escolhido devido ao seu suporte nativo ao tipo de dados ENUM, que se encaixa perfeitamente nos atributos Tipo_Cliente e Status_Pedido, tornando o modelo mais claro e garantindo a integridade dos dados. Outros SGBDs como MySQL também suportam ENUM, enquanto outros podem exigir o uso de tabelas de lookup ou constraints para simular esse comportamento.

### Nomes de Tabelas e Colunas: 
 - Os nomes foram mantidos conforme o modelo conceitual para facilitar o entendimento. Em um ambiente de produção, pode-se optar por uma padronização de nomenclatura diferente.

### Tipos de Dados: 
 - Os tipos de dados foram escolhidos com base na descrição dos atributos no modelo conceitual:
   - SERIAL em PostgreSQL é usado para chaves primárias auto-incrementáveis. Em outros SGBDs, você pode usar AUTO_INCREMENT (MySQL) ou IDENTITY (SQL Server).
   - VARCHAR(n) para strings de tamanho variável com um limite máximo de n caracteres.
   - TEXT para strings longas sem um limite específico.
   - INTEGER para números inteiros.
   - DECIMAL(10, 2) para números decimais com 10 dígitos no total, sendo 2 após a vírgula.
   - TIMESTAMP WITHOUT TIME ZONE para armazenar data e hora. DEFAULT CURRENT_TIMESTAMP define o valor padrão para a data e hora atuais na criação do registro.
   - DATE para armazenar apenas a data.
   - ENUM (PostgreSQL) para listas predefinidas de valores.

### Chaves Primárias (PK): 
 - Foram definidas chaves primárias para cada entidade para garantir a unicidade dos registros.

### Chaves Estrangeiras (FK): 
 - Foram definidas chaves estrangeiras para estabelecer os relacionamentos entre as tabelas, garantindo a integridade referencial. A cláusula FOREIGN KEY (...) REFERENCES tabela(coluna) especifica a relação.

### Chaves Primárias Compostas: 
 - Nas tabelas de ligação (como Pagamento_Pedido, Item_Pedido, Fornecimento_Produto, Estoque_Produto e Venda_Terceiro), as chaves primárias são compostas pelas chaves estrangeiras das tabelas que elas ligam, garantindo a unicidade da combinação dos registros.

### Constraint UNIQUE: 
 - Foi adicionada a constraint UNIQUE para os atributos CPF_PF e CNPJ_PJ para garantir que cada cliente (quando PF ou PJ) tenha um CPF ou CNPJ único, respectivamente.

### Constraint NOT NULL: 
 - Foi adicionada a constraint NOT NULL para atributos que são considerados obrigatórios no modelo conceitual.

### Relacionamentos: 
 - Os relacionamentos definidos no modelo conceitual foram implementados através das chaves estrangeiras nas tabelas correspondentes.
