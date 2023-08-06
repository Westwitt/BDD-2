USE bdEscola

--1
SELECT nomeAluno AS Nome, rgAluno AS RG FROM tbAluno WHERE naturalidadeAluno LIKE 'SP'

--2
SELECT nomeAluno AS Nome, rgAluno AS RG FROM tbAluno WHERE nomeAluno LIKE 'P%'

--3
SELECT nomeCurso AS Curso FROM tbCurso WHERE cargaHorariaCurso > 2000

--4
SELECT nomeAluno AS Nome, rgAluno AS RG FROM tbAluno WHERE nomeAluno LIKE '%Silva%'

--5
SELECT nomeAluno AS Nome, dataNascimentoAluno AS 'Data de nascimento' FROM tbAluno 
WHERE MONTH(dataNascimentoAluno) = 3

--6
SELECT codAluno AS 'Código aluno', dataMatricula AS 'Data matr�cula' FROM tbMatricula
WHERE MONTH(dataMatricula) = 5 

--7
SELECT codAluno AS 'Código aluno' FROM tbMatricula
WHERE codTurma = 1

--8
SELECT codAluno AS 'Código aluno' FROM tbMatricula
WHERE codTurma = 3

--9
SELECT codAluno AS 'Código aluno', nomeAluno AS 'Nome aluno', dataNascimentoAluno AS 'Data nascimento', rgAluno AS RG, naturalidadeAluno AS 'Naturalidade' FROM tbAluno

--10
SELECT codTurma AS 'Código', nomeTurma AS 'Nome', horarioTurma AS 'Horário', codCurso AS 'Código do curso' FROM tbTurma


----------------------------
SELECT nomeAluno AS Nome, DAY(dataNascimentoAluno) AS 'Dia de Nascimento', MONTH(dataNascimentoAluno) AS 'Mes de nascimento' FROM tbAluno