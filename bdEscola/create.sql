CREATE DATABASE bdEscola
USE bdEscola

CREATE TABLE tbCurso(
	codCurso INT PRIMARY KEY IDENTITY(1,1)
	, nomeCurso VARCHAR(25) NOT NULL
	, cargaHorariaCurso INT NOT NULL
	, valorCurso SMALLMONEY NOT NULL
)

CREATE TABLE tbAluno(
	codAluno INT PRIMARY KEY IDENTITY(1,1)
	, nomeAluno VARCHAR(50) NOT NULL
	, dataNascimentoAluno DATE NOT NULL
	, rgAluno VARCHAR(15) NOT NULL
	, naturalidadeAluno VARCHAR(2) NOT NULL
)

CREATE TABLE tbTurma(
	codTurma INT PRIMARY KEY IDENTITY(1,1)
	, nomeTurma VARCHAR(25) NOT NULL
	, horarioTurma TIME NOT NULL
	, codCurso INT FOREIGN KEY REFERENCES tbCurso(codCurso)
)

CREATE TABLE tbMatricula(
	codMatricula INT PRIMARY KEY IDENTITY(1,1)
	, dataMatricula DATE NOT NULL
	, codAluno INT FOREIGN KEY REFERENCES tbAluno(codAluno)
	, codTurma INT FOREIGN KEY REFERENCES tbTurma(codTurma)
)