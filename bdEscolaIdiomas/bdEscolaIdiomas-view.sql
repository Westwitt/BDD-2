USE bdEscolaIdiomas

-- 1) Crie uma visão “Preço_Baixo” que exiba o código, nome do curso, carga horária e o valor do curso de todos os cursos que tenha preço inferior ao preço médio
CREATE VIEW vwPreco_Baixo AS
	SELECT codCurso, nomeCurso, cargaHoraria, valorCurso FROM tbCurso
		WHERE valorCurso < (SELECT AVG(valorCurso) FROM tbCurso)

SELECT * FROM vwPreco_Baixo


-- 2) Usando a visão “Preço_Baixo”, mostre todos os cursos ordenados por carga horária.
SELECT * FROM vwPreco_Baixo
	ORDER BY cargaHoraria -- DESC

-- 3) Crie uma visão “Alunos_Turma” que exiba o curso e a quantidade de alunos por turma.
CREATE VIEW vwAlunos_Turma AS
	SELECT nomeCurso, COUNT(codAluno) 'Quantidade de alunos' FROM tbCurso
		INNER JOIN tbTurma ON tbTurma.codCurso = tbCurso.codCurso
			INNER JOIN tbMatricula ON tbMatricula.codTurma = tbTurma.codTurma	
				GROUP BY nomeCurso

SELECT * FROM vwAlunos_Turma

-- 4) Usando a visão “Alunos_Turma” exiba a turma com maior número de alunos.
SELECT * FROM vwAlunos_Turma
	WHERE [Quantidade de alunos] = (SELECT MAX([Quantidade de alunos]) FROM vwAlunos_Turma)

-- 5) Crie uma visão “Turma_Curso que exiba o curso e a quantidade de turmas
CREATE VIEW vwTurma_Curso AS
	SELECT nomeCurso, COUNT(codTurma) 'Quantidade de turmas' FROM tbCurso
		INNER JOIN tbTurma ON tbTurma.codCurso = tbCurso.codCurso
			GROUP BY nomeCurso

SELECT * FROM vwTurma_Curso

-- 6) Usando a visão “Turma_Curso exiba o curso com menor número de turmas.
SELECT * FROM vwTurma_Curso
	WHERE [Quantidade de turmas] = (SELECT MIN([Quantidade de turmas]) FROM vwTurma_Curso)
