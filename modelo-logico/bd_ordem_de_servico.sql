-- SGBD: PostgreSQL

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente SERIAL PRIMARY KEY,
    Tipo_Cliente ENUM('PF', 'PJ') NOT NULL,
    Nome_PF VARCHAR(50),
    CPF_PF VARCHAR(14) UNIQUE NULL,
    Razao_Social_PJ VARCHAR(50),
    CNPJ_PJ VARCHAR(18) UNIQUE NULL,
    Endereco VARCHAR(50) NOT NULL,
    Telefone VARCHAR(50) NOT NULL,
    Email VARCHAR(50)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    ID_Pedido SERIAL PRIMARY KEY,
    ID_Cliente INTEGER NOT NULL,
    Data_Criacao TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    Descricao_Pedido TEXT,
    Status_Pedido ENUM('Aberto', 'Em Andamento', 'Concluído', 'Cancelado') NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Forma_Pagamento
CREATE TABLE Forma_Pagamento (
    ID_Forma_Pagamento SERIAL PRIMARY KEY,
    Descricao_Forma_Pagamento VARCHAR(100) NOT NULL
);

-- Tabela Pagamento_Pedido (Entidade de Ligação)
CREATE TABLE Pagamento_Pedido (
    ID_Pedido INTEGER NOT NULL,
    ID_Forma_Pagamento INTEGER NOT NULL,
    Valor_Pago DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_Pedido, ID_Forma_Pagamento),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Forma_Pagamento) REFERENCES Forma_Pagamento(ID_Forma_Pagamento)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    ID_Entrega SERIAL PRIMARY KEY,
    ID_Pedido INTEGER NOT NULL UNIQUE,
    Status_Entrega ENUM('Pendente', 'Em Trânsito', 'Entregue', 'Problemas') NOT NULL,
    Codigo_Rastreio VARCHAR(50),
    Data_Envio DATE,
    Data_Prevista_Entrega DATE,
    Data_Entrega_Realizada DATE,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID_Fornecedor SERIAL PRIMARY KEY,
    Razao_Social VARCHAR(50) NOT NULL,
    CNPJ VARCHAR(18),
    Contato VARCHAR(50),
    Telefone VARCHAR(50),
    Email VARCHAR(50)
);

-- Tabela Produto
CREATE TABLE Produto (
    ID_Produto SERIAL PRIMARY KEY,
    Nome_Produto VARCHAR(50) NOT NULL,
    Descricao_Produto TEXT,
    Categoria_Produto VARCHAR(50),
    Valor_Unitario DECIMAL(10, 2) NOT NULL
);

-- Tabela Estoque
CREATE TABLE Estoque (
    ID_Estoque SERIAL PRIMARY KEY,
    Local_Estoque VARCHAR(50) NOT NULL
);

-- Tabela Terceiro_Vendedor
CREATE TABLE Terceiro_Vendedor (
    ID_Terceiro_Vendedor SERIAL PRIMARY KEY,
    Nome_Vendedor VARCHAR(50) NOT NULL,
    Contato_Vendedor VARCHAR(50)
);

-- Tabela Item_Pedido (Entidade de Ligação)
CREATE TABLE Item_Pedido (
    ID_Pedido INTEGER NOT NULL,
    ID_Produto INTEGER NOT NULL,
    Quantidade INTEGER NOT NULL,
    Valor_Unitario_Item DECIMAL(10, 2) NOT NULL,
    Subtotal_Item DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Fornecimento_Produto (Entidade de Ligação)
CREATE TABLE Fornecimento_Produto (
    ID_Fornecedor INTEGER NOT NULL,
    ID_Produto INTEGER NOT NULL,
    Preco_Custo DECIMAL(10, 2),
    PRIMARY KEY (ID_Fornecedor, ID_Produto),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Estoque_Produto (Entidade de Ligação)
CREATE TABLE Estoque_Produto (
    ID_Estoque INTEGER NOT NULL,
    ID_Produto INTEGER NOT NULL,
    Quantidade_Estoque INTEGER NOT NULL,
    PRIMARY KEY (ID_Estoque, ID_Produto),
    FOREIGN KEY (ID_Estoque) REFERENCES Estoque(ID_Estoque),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

-- Tabela Venda_Terceiro (Entidade de Ligação)
CREATE TABLE Venda_Terceiro (
    ID_Terceiro_Vendedor INTEGER NOT NULL,
    ID_Produto INTEGER NOT NULL,
    Quantidade_Vendida INTEGER NOT NULL,
    PRIMARY KEY (ID_Terceiro_Vendedor, ID_Produto),
    FOREIGN KEY (ID_Terceiro_Vendedor) REFERENCES Terceiro_Vendedor(ID_Terceiro_Vendedor),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);
