CREATE DATABASE bdDetran
GO
USE bdDetran

CREATE TABLE tbMotorista(
    codMotorista INT PRIMARY KEY IDENTITY(1,1)
    , nomeMotorista VARCHAR(100) NOT NULL
    , cpfMotorista CHAR(14) NOT NULL
    , pontuacaoAcumulada INT NOT NULL
    , situacao VARCHAR(20) NOT NULL
)

CREATE TABLE tbVeiculo(
    codVeiculo INT PRIMARY KEY IDENTITY(1,1)
    , placaVeiculo CHAR(8) NOT NULL
    , renavam CHAR(11) NOT NULL
    , anoFabricacao CHAR(4) NOT NULL
    , codMotorista INT FOREIGN KEY REFERENCES tbMotorista(codMotorista)
)

CREATE TABLE tbMulta(
    codMulta INT PRIMARY KEY IDENTITY(1,1)
    , dataMulta DATE NOT NULL
    , numPontos TINYINT NOT NULL
    , codVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(codVeiculo)
)