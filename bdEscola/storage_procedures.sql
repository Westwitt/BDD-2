-- 2
CREATE PROCEDURE spInsere_Aluno
	@nomeAluno VARCHAR(50)
	, @dataNascimentoAluno DATE
	, @cpfAluno VARCHAR(15)
	, @naturalidadeAluno VARCHAR(2)
AS
	INSERT INTO tbAluno(nomeAluno, dataNascimentoAluno, cpfAluno, naturalidadeAluno)
	VALUES
		(@nomeAluno, @dataNascimentoAluno, @cpfAluno, @naturalidadeAluno)

EXEC spInsere_Aluno 'Bruno', '05/13/2006', '82.292.122-0', 'SP'

-- 4
CREATE PROCEDURE spExibe_Turma
	@nomeTurma VARCHAR(25)
AS
	SELECT nomeTurma, horarioTurma, nomeCurso, cargaHorariaCurso, valorCurso FROM tbTurma
		INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
			WHERE nomeTurma LIKE @nomeTurma

exec spExibe_Turma '1AA'

-- 6
CREATE PROCEDURE spCria_Aluno
	@nomeAluno VARCHAR(50)
	, @dataNascimentoAluno DATE
	, @cpfAluno VARCHAR(15)
	, @naturalidadeAluno VARCHAR(2)
AS
	DECLARE @cod INT
	IF EXISTS (SELECT codAluno FROM tbAluno WHERE cpfAluno LIKE @cpfAluno)
	BEGIN
		PRINT('IMPOSSIVEL CADASTRAR, CPF JÁ EXISTE!!!')
	END
	ELSE
	BEGIN
		INSERT INTO tbAluno(nomeAluno, dataNascimentoAluno, cpfAluno, naturalidadeAluno)
		VALUES
			(@nomeAluno, @dataNascimentoAluno, @cpfAluno, @naturalidadeAluno)

		SET @cod = (SELECT MAX(codAluno) FROM tbAluno)

		PRINT('ALUNO CADASTRADO COM O CODIGO: '+CONVERT(VARCHAR(10), @cod))
	END

EXEC spCria_Aluno 'Bruno Oliveira', '05/05/2005', '82.292.122-1', 'SP'