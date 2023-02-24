CREATE DATABASE bdKhanAcademy
GO
USE bdKhanAcademy

CREATE TABLE tbCampus(
	idCampus INT PRIMARY KEY IDENTITY(1,1)
	,nomeCampus VARCHAR(50) UNIQUE	NOT NULL
	,logCampus VARCHAR(50) NOT NULL
	,numCampus VARCHAR(5) NOT NULL
	,bairroCampus VARCHAR(50) NOT NULL
	,cidadeCampus VARCHAR(50) NOT NULL
	,estadoCampus VARCHAR(50) NOT NULL
	,cepCampus CHAR(9) NOT NULL
)

CREATE TABLE tbCurso(
	idCurso INT PRIMARY KEY IDENTITY(1,1)
	,descCurso VARCHAR(50) NOT NULL
	,cargaHoraria INT NOT NULL
)

CREATE TABLE tbCursoCampus(
	idCursoCampus INT PRIMARY KEY IDENTITY(1,1)
	,idCampus INT FOREIGN KEY REFERENCES tbCampus(idCampus)
	,idCurso INT FOREIGN KEY REFERENCES tbCurso(idCurso)
)

CREATE TABLE tbTurma(
	idTurma INT PRIMARY KEY IDENTITY(1,1)
	,idCurso INT FOREIGN KEY REFERENCES tbCurso(idCurso)
	,descTurma VARCHAR(10) NOT NULL
	,anoFormacao DATETIME NOT NULL
	,numSala SMALLINT  NOT NULL
)

CREATE TABLE tbDisciplina(
	idDisciplina INT PRIMARY KEY IDENTITY(1,1)
	,descDisciplina VARCHAR(50) NOT NULL
	,aulasDisciplina SMALLINT NOT NULL
)

CREATE TABLE tbProfessor(
	idProfessor INT PRIMARY KEY IDENTITY(1,1)
	,nomeProfessor VARCHAR(50) NOT NULL
	,cpfProfessor CHAR(11) NOT NULL UNIQUE
	,salarioProfessor SMALLMONEY NOT NULL
)

CREATE TABLE tbTelefoneProf(
	idTelefoneProf INT PRIMARY KEY IDENTITY(1,1)
	,numProf VARCHAR(11) NOT NULL UNIQUE
	,idProfessor INT FOREIGN KEY REFERENCES tbProfessor(idProfessor)
)

CREATE TABLE tbAtribuicao(
	idAtribuicao INT PRIMARY KEY IDENTITY(1,1)
	,idDisciplina INT FOREIGN KEY REFERENCES tbDisciplina(idDisciplina)
	,idTurma INT FOREIGN KEY REFERENCES tbTurma(idTurma)
	,idProfessor INT FOREIGN KEY REFERENCES tbProfessor(idProfessor)
)

CREATE TABLE tbAluno(
	idAluno INT PRIMARY KEY IDENTITY(1,1)
	,nomeAluno VARCHAR(50) NOT NULL
	,logAluno VARCHAR(50) NOT NULL
	,numAluno VARCHAR(5) NOT NULL
	,bairroAluno VARCHAR(50) NOT NULL
	,cidadeAluno VARCHAR(50) NOT NULL
	,estadoAluno VARCHAR(50) NOT NULL
	,cepAluno CHAR(9) NOT NULL
	,cpfAluno CHAR(11) NOT NULL UNIQUE
)

CREATE TABLE tbTelefoneAluno(
	idTelefoneAluno INT PRIMARY KEY IDENTITY(1,1)
	,numAluno VARCHAR(11) NOT NULL UNIQUE
	,idAluno INT FOREIGN KEY REFERENCES tbAluno(idAluno)
)

CREATE TABLE tbMatricula(
	idMatricula INT PRIMARY KEY IDENTITY(1,1)
	,diaMatricula DATE NOT NULL
	,idAluno INT FOREIGN KEY REFERENCES tbAluno(idAluno)
	,idTurma INT FOREIGN KEY REFERENCES tbTurma(idTurma)
)