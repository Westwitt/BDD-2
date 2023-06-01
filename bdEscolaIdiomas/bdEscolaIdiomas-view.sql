USE bdEscolaIdiomas

-- 1) Crie uma vis�o �Pre�o_Baixo� que exiba o c�digo, nome do curso, carga hor�ria e o valor do curso de todos os cursos que tenha pre�o inferior ao pre�o m�dio
CREATE VIEW vwPreco_Baixo AS
	SELECT codCurso, nomeCurso, cargaHoraria, valorCurso FROM tbCurso
		WHERE valorCurso < (SELECT AVG(valorCurso) FROM tbCurso)

SELECT * FROM vwPreco_Baixo


-- 2) Usando a vis�o �Pre�o_Baixo�, mostre todos os cursos ordenados por carga hor�ria.
SELECT * FROM vwPreco_Baixo
	ORDER BY cargaHoraria -- DESC

-- 3) Crie uma vis�o �Alunos_Turma� que exiba o curso e a quantidade de alunos por turma.