CREATE DATABASE bdConfeitariaSonho
GO
USE bdConfeitariaSonho

CREATE TABLE tbCliente(
	codCliente INT PRIMARY KEY IDENTITY(1,1)
	,nomeCliente VARCHAR(50) NOT NULL
	,dataNascimentoCliente DATETIME NOT NULL
	,ruaCliente VARCHAR(50) NOT NULL
	,numCasaCliente VARCHAR(5) NOT NULL
	,cepCliente CHAR(10) NOT NULL
	,bairroCliente VARCHAR(50) NOT NULL
	,cidadeCliente VARCHAR(50) NOT NULL
	,estadoCliente VARCHAR(50) NOT NULL
	,cpfCliente CHAR(14) NOT NULL
	,sexoCliente CHAR(1) NOT NULL
)

CREATE TABLE tbEncomenda(
	codEncomenda INT PRIMARY KEY IDENTITY(1,1)
	, dataEncomenda DATE NOT NULL
	, valorTotalEncomenda MONEY NOT NULL
	, dataEntregaEncomenda DATE NOT NULL
	, codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente)
)

CREATE TABLE tbCategoriaProduto(
	codCategoriaProduto INT PRIMARY KEY IDENTITY(1,1)
	,nomeCategoriaProduto VARCHAR(50) NOT NULL
)

CREATE TABLE tbProduto(
	codProduto INT PRIMARY KEY IDENTITY(1,1)
	, nomeProduto VARCHAR(50) NOT NULL
	, precoKiloProduto MONEY NOT NULL
	, codCategoriaProduto INT FOREIGN KEY REFERENCES tbCategoriaProduto(codCategoriaProduto)
)

CREATE TABLE tbItensEncomenda(
	codItensEncomenda INT PRIMARY KEY IDENTITY(1,1)
	,quantidadeKilos FLOAT(24) NOT NULL
	,subTotal MONEY NOT NULL
	,codEncomenda INT FOREIGN KEY REFERENCES tbEncomenda(codEncomenda)
	,codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto)
)