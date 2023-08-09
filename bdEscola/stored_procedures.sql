USE bdEscola

-- 1
CREATE PROCEDURE spBusca_Aluno
	@codAluno INT
AS
	SELECT nomeAluno, dataNascimentoAluno FROM tbAluno
		WHERE codAluno = @codAluno

EXEC spBusca_Aluno 3



SELECT * from tbAluno

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

EXEC spInsere_Aluno 'Juquinha', '05/06/2006', '82.292.122-0', 'SP'


-- 3
CREATE PROCEDURE spAumenta_Preco
	@nomeCurso VARCHAR(25)
	, @percentual FLOAT(24)
AS 
	UPDATE tbCurso
		SET valorCurso = valorCurso * (@percentual / 100 + 1)
			WHERE nomeCurso LIKE @nomeCurso
	
EXEC spAumenta_Preco 'Inglês', 20.0


	

-- 4
CREATE PROCEDURE spExibe_Turma
    @nomeTurma VARCHAR(25)
AS
    SELECT nomeTurma, horarioTurma, nomeCurso, cargaHorariaCurso, valorCurso FROM tbTurma
        INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
            WHERE nomeTurma LIKE @nomeTurma

exec spExibe_Turma '1AA'


-- 5
CREATE PROCEDURE spExibe_AlunosdaTurma
	@nomeTurma VARCHAR(25)
AS
	SELECT nomeAluno FROM tbAluno
		INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
			INNER JOIN tbTurma ON tbTurma.codTurma = tbMatricula.codTurma
				WHERE nomeTurma LIKE @nomeTurma

EXEC spExibe_AlunosdaTurma '1AA'

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

EXEC spCria_Aluno 'el tug', '05/05/2005', '82.292.122-1', 'SP'

-- 7
CREATE PROCEDURE spMatricula_Aluno
	@nomeAluno VARCHAR(50)
	,@nomeTurma VARCHAR(25)
AS
	INSERT INTO tbMatricula (dataMatricula, codAluno, codTurma )
	VALUES
		(GETDATE(), (SELECT codAluno FROM tbAluno WHERE nomeAluno LIKE @nomeAluno), (SELECT codTurma FROM tbTurma WHERE nomeTurma LIKE @nomeTurma) )

EXEC spMatricula_Aluno 'Juquinha', '1AA'
