USE bdEstoque
GO

-- 1) Criar uma função que retorne o dia de semana da venda (no formato segunda, terça, etc) ao lado do código da venda, valor total da venda e sua data
CREATE FUNCTION fc_ResumoVenda(@Venda INT)
RETURNS VARCHAR(40)

AS
BEGIN
	DECLARE @Return VARCHAR(40)
	DECLARE @Dia INT = (SELECT DatePart(dw,dataVenda) FROM tbVenda WHERE codVenda = @Venda)
	
	DECLARE @DiaSemana VARCHAR(30)

	IF @Dia = 1
	BEGIN
		SET @DiaSemana = 'Domigo'
	END

	IF @Dia = 2
	BEGIN
		SET @DiaSemana = 'Segunda-Feira'
	END

	ELSE IF @Dia = 3
	BEGIN
		SET @DiaSemana = 'Terça-Feira'
	END

	IF @Dia = 4
	BEGIN
		SET @DiaSemana = 'Quarta-Feira'
	END

	IF @Dia = 5
	BEGIN
		SET @DiaSemana = 'Quinta-Feira'
	END

	IF @Dia = 6
	BEGIN
		SET @DiaSemana = 'Sexta-Feira'
	END

	IF @Dia = 7
	BEGIN
		SET @DiaSemana = 'Sábado'
	END

	SET @Return = (SELECT @DiaSemana + ' / ' + CONVERT(VARCHAR(10), codVenda) + ' / ' + CONVERT(VARCHAR(10), valorTotalVenda) + ' / ' + CONVERT(VARCHAR(10),dataVenda) FROM tbVenda WHERE codVenda = @Venda)
	RETURN @Return
END

SELECT ResumoVendas=dbo.fc_ResumoVenda(codVenda) FROM tbVenda

-- 2) Criar uma função que receba o código do cliente e retorne o total de vendas que o cliente já realizou
CREATE FUNCTION fc_VendasCliente(@Cliente INT)
RETURNS INT

AS
BEGIN
	DECLARE @vendas INT
	SET @vendas = (SELECT COUNT(codVenda) FROM tbVenda WHERE codCliente	= @Cliente)
	RETURN @vendas
END

PRINT(dbo.fc_VendasCliente(1))

-- 3) Criar uma função que receba o código de um vendedor e o mês e informe o total de vendas do vendedor no mês informado
CREATE FUNCTION fc_QuantidadeVendasMes(@Vendedor INT, @Mes INT)
RETURNS INT

AS
BEGIN
	DECLARE @Result INT

	SET @Result = (SELECT COUNT(codVenda) FROM tbVenda
		WHERE codVendedor = @Vendedor AND MONTH(dataVenda) = @Mes)
	
	RETURN @Result
END

PRINT(dbo.fc_QuantidadeVendasMes(1, 2))

-- 4) Criar uma função que usando o bdEstoque diga se o cpf do cliente é ou não válido
CREATE FUNCTION fc_ValidarCPF(@Cliente INT)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @valido VARCHAR(20),
	@i INT,
	@n1 INT,
	@n2 INT,
	@dig1 INT,
	@igual BIT,
	@cpf CHAR(11),
	@resto INT

	
	SET @i = 1
	SET @igual = 1
	SET @valido = 'Invalido'
	SET @cpf = (SELECT cpfCliente FROM tbCliente WHERE codCliente = @Cliente)
	SET @dig1 = SUBSTRING(@cpf, 1, 1)

	WHILE(@i <= 11)
	BEGIN
		IF SUBSTRING(@cpf, @i, 1) <> @dig1
		BEGIN
			SET @igual = 0
		END
		SET @i = @i+1
	END

	IF @igual = 0
	BEGIN
		SET @i = 1
		DECLARE @soma INT SET @soma = 0
		
		WHILE (@i <= 9)
		BEGIN
			SET @soma = @soma + (CONVERT(INT, SUBSTRING(@cpf, (@i), 1)) * (11 - @i))
			SET @i = @i+1
		END

		SET @resto = @soma % 11
		IF @resto < 2
		BEGIN
			SET @n1 = 0
		END
		ELSE
		BEGIN
			SET @n1 = 11 - @resto
		END

		SET @i = 1
		SET @soma = 0
		
		WHILE (@i <= 10)
		BEGIN
			SET @soma = @soma + (CONVERT(INT, SUBSTRING(@cpf, (@i), 1)) * (12 - @i))
			SET @i = @i+1
		END

		SET @resto = @soma % 11
		IF @resto < 2
		BEGIN
			SET @n2 = 0
		END
		ELSE
		BEGIN
			SET @n2 = 11 - @resto
		END

		DECLARE @minicpf CHAR(9) 
		SET @minicpf = SUBSTRING(@cpf, 1, 9)

		IF CONCAT(@minicpf, @n1, @n2) = @cpf
		BEGIN
			SET @valido = 'Valido'
		END
	END
	
	RETURN @valido
END

PRINT(dbo.fc_ValidarCPF(1))
