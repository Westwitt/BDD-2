--Criação do banco de dados

CREATE DATABASE bdOrganizacao

GO

USE bdOrganizacao

CREATE TABLE tbStatus(
	idStatus INT PRIMARY KEY IDENTITY(1,1)
	,descStatus VARCHAR(50) NOT NULL
)

CREATE TABLE tbSexo(
	idSexo INT PRIMARY KEY IDENTITY(1,1)
	,descSexo VARCHAR(50) NOT NULL
)

CREATE TABLE tbCrianca(
	idCrianca INT PRIMARY KEY IDENTITY(1,1)
	,nomeCrianca VARCHAR(50) NOT NULL
	,dtNascCrianca SMALLDATETIME NOT NULL
	,idStatus INT FOREIGN KEY REFERENCES tbStatus(idStatus)
	,idSexo INT FOREIGN KEY REFERENCES tbSexo(idSexo)
)

CREATE TABLE tbResponsavel(
	idResponsavel INT PRIMARY KEY IDENTITY(1,1)
	,nomeResponsavel VARCHAR(50) NOT NULL
	,cpfResponsavel CHAR(11) NOT NULL
)

CREATE TABLE tbPadrinho(
	idPadrinho INT PRIMARY KEY IDENTITY(1,1)
	,nomePadrinho VARCHAR(50) NOT NULL
	,cpfPadrinho CHAR(11) NOT NULL
)

CREATE TABLE tbDoenca(
	idDoenca INT PRIMARY KEY IDENTITY(1,1)
	,nomeDoenca VARCHAR(50) NOT NULL
	,cid CHAR(3) NOT NULL UNIQUE
)

CREATE TABLE Filiacao(
	idFiliacao INT PRIMARY KEY IDENTITY(1,1)
	,idResponsavel INT FOREIGN KEY REFERENCES tbResponsavel(idResponsavel)
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca(idCrianca)
	,dtFiliacao DATETIME NOT NULL
)

CREATE TABLE tbApadrinhamento(
	idApadrinhamento INT PRIMARY KEY IDENTITY(1,1)
	,idPadrinho INT FOREIGN KEY REFERENCES tbPadrinho(idPadrinho)
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca(idCrianca)
	,dtApadrinhamento DATETIME NOT NULL
)

CREATE TABLE tbRegistroPontuario(
	idRegPontuario INT PRIMARY KEY IDENTITY(1,1)
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca(idCrianca)
	,idDoenca INT FOREIGN KEY REFERENCES tbDoenca(idDoenca)
	,dataRegistro DATETIME NOT NULL
)

CREATE TABLE tbHistorico(
	idHistorico INT PRIMARY KEY IDENTITY(1,1)
	,dataHistorico DATETIME NOT NULL
	,idCrianca INT FOREIGN KEY REFERENCES tbCrianca(idCrianca)
)