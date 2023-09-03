-- Desafio de projeto do bootcamp da DIO - Potência Tech powered by IFood - Ciências de Dados com Python

-- Constra um Projeto Lógico de Banco de Dados do Zero.

-- DDL & DML:

-- Criação da tabela Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(255)
);

-- Criação da tabela Veiculos
CREATE TABLE Veiculos (
    VeiculoID INT PRIMARY KEY,
    Placa VARCHAR(10),
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Ano INT,
    ClienteID INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Criação da tabela Funcionarios
CREATE TABLE Funcionarios (
    FuncionarioID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Cargo VARCHAR(100)
);

-- Criação da tabela Servicos
CREATE TABLE Servicos (
    ServicoID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao VARCHAR(255),
    Preco DECIMAL(10, 2)
);

-- Criação da tabela OrdensDeServico
CREATE TABLE OrdensDeServico (
    OrdemID INT PRIMARY KEY,
    DataInicio DATE,
    DataFim DATE,
    VeiculoID INT,
    FuncionarioID INT,
    FOREIGN KEY (VeiculoID) REFERENCES Veiculos(VeiculoID),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(FuncionarioID)
);

-- Criação da tabela Pecas
CREATE TABLE Pecas (
    PecaID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao VARCHAR(255),
    Preco DECIMAL(10, 2)
);

-- Criação da tabela OrdemDeServicoPecas
CREATE TABLE OrdemDeServicoPecas (
    OrdemID INT,
    PecaID INT,
    Quantidade INT,
    PRIMARY KEY (OrdemID, PecaID),
    FOREIGN KEY (OrdemID) REFERENCES OrdensDeServico(OrdemID),
    FOREIGN KEY (PecaID) REFERENCES Pecas(PecaID)
);

-- Criação da tabela OrdemDeServicoServicos
CREATE TABLE OrdemDeServicoServicos (
    OrdemID INT,
    ServicoID INT,
    Quantidade INT,
    PRIMARY KEY (OrdemID, ServicoID),
    FOREIGN KEY (OrdemID) REFERENCES OrdensDeServico(OrdemID),
    FOREIGN KEY (ServicoID) REFERENCES Servicos(ServicoID)
);



-- INSERÇÃO DADOS

-- Inserção de dados de exemplo para Clientes
INSERT INTO Clientes (ClienteID, Nome, Telefone, Email)
VALUES (1, 'João Silva', '123-456-7890', 'joao@email.com');

-- Inserção de dados de exemplo para Veiculos
INSERT INTO Veiculos (VeiculoID, Placa, Marca, Modelo, Ano, ClienteID)
VALUES (1, 'ABC123', 'Toyota', 'Corolla', 2020, 1);

-- Inserção de dados de exemplo para Funcionarios
INSERT INTO Funcionarios (FuncionarioID, Nome, Cargo)
VALUES (1, 'Maria Santos', 'Mecânico');

-- Inserção de dados de exemplo para Pecas
INSERT INTO Pecas (PecaID, Nome, Descricao, Preco)
VALUES (1, 'Filtro de Óleo', 'Filtro de óleo para veículos', 15.99);

-- Inserção de dados de exemplo para Servicos
INSERT INTO Servicos (ServicoID, Nome, Descricao, Preco)
VALUES (1, 'Troca de Óleo', 'Troca de óleo e filtro de óleo', 39.99);

-- Inserção de dados de exemplo para OrdensDeServico
INSERT INTO OrdensDeServico (OrdemID, DataInicio, VeiculoID, FuncionarioID)
VALUES (1, '2023-09-01', 1, 1);

-- Inserção de dados de exemplo para OrdemDeServicoPecas
INSERT INTO OrdemDeServicoPecas (OrdemID, PecaID, Quantidade)
VALUES (1, 1, 1);

-- Inserção de dados de exemplo para OrdemDeServicoServicos
INSERT INTO OrdemDeServicoServicos (OrdemID, ServicoID, Quantidade)
VALUES (1, 1, 1);



-- CONSULTAS

-- Recuperação simples de todos os clientes
SELECT * FROM Clientes;


-- Filtragem de ordens de serviço em aberto para um cliente específico
SELECT * FROM OrdensDeServico
WHERE DataFim IS NULL
AND VeiculoID IN (SELECT VeiculoID FROM Veiculos WHERE ClienteID = 1);


-- Ordenação das ordens de serviço por data de início em ordem decrescente
SELECT * FROM OrdensDeServico
ORDER BY DataInicio DESC;


-- Filtragem de funcionários que realizaram mais de 3 ordens de serviço
SELECT FuncionarioID, COUNT(*) AS TotalOrdens
FROM OrdensDeServico
GROUP BY FuncionarioID
HAVING COUNT(*) > 3;
