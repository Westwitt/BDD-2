USE bdEscola
GO

-- 1) Crie uma função que informada uma data da matrícula, retorne o dia da semana.
CREATE FUNCTION fc_DiaSemanaMatricula(@DataMatricula DATE)
RETURNS VARCHAR(30)

AS
BEGIN
	DECLARE @DiaSemana VARCHAR(30)
	DECLARE @Dia INT

	SET @Dia = DATEPART(dw, @DataMatricula)

	IF @Dia = 1
	BEGIN
		SET @DiaSemana = 'Domigo'
	END

	ELSE IF @Dia = 2
	BEGIN
		SET @DiaSemana = 'Segunda-Feira'
	END

	ELSE IF @Dia = 3
	BEGIN
		SET @DiaSemana = 'Terça-Feira'
	END

	ELSE IF @Dia = 4
	BEGIN
		SET @DiaSemana = 'Quarta-Feira'
	END

	IF @Dia = 5
	BEGIN
		SET @DiaSemana = 'Quinta-Feira'
	END

	ELSE IF @Dia = 6
	BEGIN
		SET @DiaSemana = 'Sexta-Feira'
	END

	ELSE IF @Dia = 7
	BEGIN
		SET @DiaSemana = 'Sábado'
	END

	RETURN @DiaSemana

END

PRINT(dbo.fc_DiaSemanaMatricula('2006-05-13'))

-- 2) Crie uma função que de acordo com a carga horária do curso exiba curso rápido ou curso extenso. (Rápido menos de 1000 horas).

CREATE FUNCTION fc_TempoCurso(@Curso INT)
RETURNS VARCHAR(20)

AS
BEGIN
	DECLARE @tempo INT
	DECLARE @retorno VARCHAR(20)
	SET @tempo = (SELECT cargaHorariaCurso FROM tbCurso WHERE codCurso = @Curso)

	IF @tempo >= 1000
		BEGIN
			SET @retorno = 'Curso extenso'
		END
	ELSE IF @tempo < 1000
		BEGIN
			SET @retorno = 'Curso rapido'
		END
	ELSE
		BEGIN
			SET @retorno = 'Curso invalido'
		END
	RETURN @retorno
END

PRINT (dbo.fc_TempoCurso(1))

-- 3) Crie uma função que de acordo com o valor do curso exiba  curso caro ou curso barato. (Curso caro acima de 400).
CREATE FUNCTION fc_CaroBaratoCurso(@Curso INT)
RETURNS VARCHAR(20)

AS
BEGIN
	DECLARE @valor SMALLMONEY
	DECLARE @resultado VARCHAR(20)
	SET @valor = (SELECT valorCurso FROM tbCurso WHERE codCurso = @Curso)

	IF @valor > 400
		BEGIN
			SET @resultado = 'Curso caro'
		END
	ELSE IF @valor <= 400
		BEGIN
			SET @resultado = 'Curso barato'
		END
	ELSE
		BEGIN
			SET @resultado = 'Curso invalido'
		END
	RETURN @resultado
END

PRINT (dbo.fc_CaroBaratoCurso(2))

-- 4) Criar uma função que informada a data da matrícula converta-a no formato dd/mm/aaaa.

CREATE FUNCTION fc_DataMatricula(@Matricula DATE)
RETURNS CHAR(10)

AS
BEGIN
	DECLARE @data CHAR(10)
	SET @data = CONVERT(VARCHAR, @Matricula, 103)

	RETURN @data
END

PRINT (dbo.fc_DataMatricula('2015-03-10'))