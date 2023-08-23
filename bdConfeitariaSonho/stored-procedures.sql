USE bdConfeitariaSonho
SET DATEFORMAT DMY;

-- a) Criar uma StoredProcedure para inserir as categorias de produto conforme abaixo: Ao inserir uma categoria de produto, confirmar pelo seu nome se o mesmo j� existe no banco de dados. Nesse caso, enviar uma mensagem com essa situa��o ao usu�rio.
CREATE PROCEDURE spCadastrar_Categoria
	@nomeCategoria VARCHAR(50)
AS
	IF EXISTS (SELECT nomeCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE @nomeCategoria)
		BEGIN
			PRINT 'Essa categoria ja existe!'
		END
	ELSE
		BEGIN
		INSERT INTO tbCategoriaProduto(nomeCategoriaProduto)
		VALUES
			(@nomeCategoria)
		END

EXEC spCadastrar_Categoria 'Bolo Festa'
EXEC spCadastrar_Categoria 'Bolo Simples'
EXEC spCadastrar_Categoria 'Torta'
EXEC spCadastrar_Categoria 'Salgado'

-- b) Criar  uma  Stored Procedure  para  inserir os  produtos abaixo,  sendo  que,  a  procedure  devera antes de inserir verificar se o nome do produto ja existe, evitando assim que um produto seja duplicado:
CREATE PROCEDURE spInserir_Produto
	@nomeProduto VARCHAR(50)
	, @precoKilo MONEY
	, @categoriaProduto INT
AS
	IF NOT EXISTS (SELECT nomeProduto FROM tbProduto WHERE nomeProduto LIKE @nomeProduto)
	BEGIN
		INSERT INTO tbProduto(nomeProduto, precoKiloProduto, codCategoriaProduto) VALUES
			(@nomeProduto, @precoKilo, @categoriaProduto)
	END
	ELSE
	BEGIN
		PRINT('Produto ja cadastrado!')
	END

EXEC spInserir_Produto 'Bolo Floresta Negra', 42, 1
EXEC spInserir_Produto 'Bolo Prestigio', 43, 1
EXEC spInserir_Produto 'Bolo Nutella', 44, 1
EXEC spInserir_Produto 'Bolo Formigueiro', 17, 2 
EXEC spInserir_Produto 'Bolo de cenoura', 19, 2
EXEC spInserir_Produto 'Torta de palmito', 45, 3
EXEC spInserir_Produto 'Torta de frango e catupiry', 47, 3 
EXEC spInserir_Produto 'Torta de escarola', 44, 3
EXEC spInserir_Produto 'Coxinha frango', 25, 4
EXEC spInserir_Produto 'Esfiha carne', 27,4
EXEC spInserir_Produto 'Folhado queijo', 31,4
EXEC spInserir_Produto 'Risoles misto', 29, 4

/*
c) Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que deverao ser feitas duas validacoes:
	-Verificar pelo CPF se o cliente ja existe. Caso ja exista emitir a mensagem: 'Cliente cpf XXXXX ja cadastrado'
	-Verificar  se  o  cliente  e  morador  de  Itaquera  ou  Guaianases,  pois  a  confeitaria  nao  realiza entregas para clientes que residam fora desses bairros. Caso o cliente nao seja morador desses bairros enviar a mensagem 'Nao foi possivel cadastrar o cliente XXXX pois o bairro XXXX nao e atendido pela confeitaria'
*/
CREATE PROCEDURE spCadastrar_Cliente
	@nomeCliente VARCHAR(50)
	,@dataNascimentoCliente DATETIME
	,@ruaCliente VARCHAR(50)
	,@numCasaCliente VARCHAR(5)
	,@cepCliente CHAR(10)
	,@bairroCliente VARCHAR(50)
	,@cidadeCliente VARCHAR(50)
	,@estadoCliente VARCHAR(50)
	,@cpfCliente CHAR(14)
	,@sexoCliente CHAR(1)
AS
	IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente = @cpfCliente)
	BEGIN
		PRINT 'Cliente CPF '+@cpfCliente+' ja cadastrado'
	END
	ELSE IF @bairroCliente NOT LIKE 'Itaquera' AND @bairroCliente NOT LIKE 'Guaianases'
	BEGIN
		PRINT 'Nao foi possivel cadastrar o cliente '+@nomeCliente+', pois o bairro '+@bairroCliente+' nao e atendido pela confeitaria'
	END
	ELSE
	BEGIN
		INSERT INTO tbCliente(nomeCliente, dataNascimentoCliente, ruaCliente, numCasaCliente, cepCliente, bairroCliente, cidadeCliente, estadoCliente, cpfCliente, sexoCliente)
		VALUES
			(@nomeCliente, @dataNascimentoCliente, @ruaCliente, @numCasaCliente, @cepCliente, @bairroCliente, @cidadeCliente, @estadoCliente, @cpfCliente, @sexoCliente)
	END


EXEC spCadastrar_Cliente 'Samira Fatah', '05/05/1990', 'Rua Aguapei', '1000', '08.090-000', 'Guaianases', 'Sao Paulo', 'SP', '652.624.069-04', 'F'
EXEC spCadastrar_Cliente 'Celia Nogueira', '06/06/1992', 'Rua Andes', '234', '08.456-090', 'Guaianases', 'Sao Paulo', 'SP', '856.598.243-23', 'F'
EXEC spCadastrar_Cliente 'Paulo Cesar Siqueira', '04/04/1984', 'Rua Castelo do Piaui', '232', '08.109-000', 'Itaquera', 'Sao Paulo', 'SP', '844.054.125-29', 'M'
EXEC spCadastrar_Cliente 'Rodrigo Favaroni', '09/04/1991', 'Rua Sansao Castelo Branco', '10', '08.431-090', 'Guaianases', 'Sao Paulo', 'SP', '643.073.023-97', 'M'
EXEC spCadastrar_Cliente 'Flavia Regina Brito', '22/04/1992', 'Mariano Moro', '300', '08.200-123', 'Itaquera', 'Sao Paulo', 'SP', '830.641.067-08', 'F'

/*
d) Criar via stored procedureas encomendas abaixo relacionadas, fazendo as verificacoes abaixo:
	-No  momento  da  encomenda  o  cliente  ira  fornecer  o  seu  cpf.  Caso  ele  nao  tenha  sido cadastrado enviar a mensagem 'nao foi possivel efetivar a encomenda pois o cliente xxxx nao esta cadastrado'
	-Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: 'Encomenda XXX para  o cliente YYY efetuada com sucessoo sendo que no lugar de XXX devera aparecer o numero da encomenda e no YYY devera aparecer o nome do cliente;
*/
CREATE PROCEDURE spEncomendar
	@cpfCliente CHAR(14)
	, @dataEncomenda DATE
	, @valorTotalEncomenda MONEY
	, @dataEntrega DATE
AS
	DECLARE @codCliente AS INT = (SELECT codCliente FROM tbCliente WHERE cpfCliente = @cpfCliente)

	IF @codCliente IS NOT NULL
	BEGIN
		INSERT INTO tbEncomenda(dataEncomenda, valorTotalEncomenda, dataEntregaEncomenda, codCliente)
		VALUES
			(@dataEncomenda, @valorTotalEncomenda, @dataEntrega, @codCliente)

		DECLARE @numeroEncomenda AS INT = (SELECT MAX(codEncomenda) FROM tbEncomenda)
		DECLARE @nomeCliente AS VARCHAR(50) = (SELECT nomeCliente FROM tbCliente WHERE codCliente = @codCliente)

		PRINT('Encomenda '+CONVERT(VARCHAR(10), @numeroEncomenda)+' para  o cliente '+@nomeCliente+' efetuada com sucesso')
	END
	ELSE
	BEGIN
		PRINT('Nao foi possivel efetivar a encomenda pois o cliente '+@cpfCliente+' nao esta cadastrado')
	END

EXEC spEncomendar '652.624.069-04', '08/08/2015', 450, '15/08/2015'
EXEC spEncomendar '856.598.243-23', '10/10/2015', 200, '15/10/2015'
EXEC spEncomendar '844.054.125-29', '10/10/2015', 150, '10/12/2015'
EXEC spEncomendar '652.624.069-04', '06/10/2015', 250, '12/10/2015'
EXEC spEncomendar '643.073.023-97', '05/10/2015', 150, '12/10/2015'

--e) Ao adicionar a encomenda, criar uma Storedprocedure, para que sejaminseridos os itens da encomenda conforme tabela a seguir. 

CREATE PROCEDURE spInserir_Items
	@codEncomenda INT 
	,@codProduto INT
	,@quantidadeKilos FLOAT(24)
	,@subTotal MONEY
AS
	INSERT INTO tbItensEncomenda(quantidadeKilos, subTotal, codEncomenda, codProduto)
	VALUES
		(@quantidadeKilos, @subTotal, @codEncomenda, @codProduto)

EXEC spInserir_Items 1, 1, 2.5, 105
EXEC spInserir_Items 1, 10, 2.6, 70
EXEC spInserir_Items 1, 9, 6, 150
EXEC spInserir_Items 1, 12, 4.3, 125
EXEC spInserir_Items 2, 9, 8, 200
EXEC spInserir_Items 3, 11, 3.2, 100
EXEC spInserir_Items 3, 9, 2, 50
EXEC spInserir_Items 4, 2, 3.5, 150
EXEC spInserir_Items 4, 3, 2.2, 100
EXEC spInserir_Items 5, 6, 3.4, 150

/* f) Apos todos os cadastros, criar Storedprocedures para alterar o que se pede:
	1-O preco dos produtos da categoria �Bolo festa� sofreram um aumento de 10%
	2-O preco dos produtos categoria �Bolo simples� estao em promocao e terao um desconto de 20%;
	3-O preco dos produtos categoria �Torta� aumentaram 25%
	4-O preco dos produtos categoria �Salgado�, com excecao da esfihade carne, sofreram um aumento de 20%
*/
CREATE PROCEDURE spAumentoPreco
	@categoria VARCHAR(50)
	, @aumento FLOAT(24)
	, @excecao VARCHAR(50) = ''
AS
	DECLARE @codCategoria INT = (SELECT codCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE @categoria)
	UPDATE tbProduto
		SET precoKiloProduto = precoKiloProduto + (precoKiloProduto * @aumento / 100)
			WHERE codCategoriaProduto = @codCategoria AND nomeProduto <> @excecao

EXEC spAumentoPreco 'Bolo Festa', 10
EXEC spAumentoPreco 'Bolo Simples', 20
EXEC spAumentoPreco 'Torta', 25
EXEC spAumentoPreco 'Salgado', 20, 'Esfiha carne'

/* g) Criar uma procedure para excluir clientes pelo CPF sendo que:
	1-Caso o cliente  possua  encomendas emitir a mensagem �Imposs�vel  remover  esse  cliente  pois  o cliente XXXXX possui encomendas; onde XXXXX � o nome do cliente.
	2-Caso o cliente n�o possua encomendas realizar a remo��o e emitir a mensagem �Cliente XXXX removido com sucesso�, onde XXXX � o nome do cliente;
*/
CREATE PROCEDURE spExcluirCliente
	@cpfCliente CHAR(14)
AS 
	DECLARE @nome VARCHAR(50) = (SELECT nomeCliente FROM tbCliente WHERE cpfCliente = @cpfCliente)
	IF EXISTS (SELECT codEncomenda FROM tbEncomenda 
		INNER JOIN tbCliente ON tbCliente.codCliente = tbEncomenda.codCliente
			WHERE cpfCliente = @cpfCliente)
	BEGIN
		PRINT('Impossível remover esse cliente pois o cliente '+@nome+' possui encomendas')
	END
	ELSE
	BEGIN
		DELETE FROM tbCliente WHERE cpfCliente = @cpfCliente;
		PRINT('Cliente '+@nome+' removido com sucesso')
	END

EXEC spExcluirCliente '830.641.067-08'
EXEC spExcluirCliente '643.073.023-97'

-- h) Criar uma procedure que permita excluir qualquer item de uma encomenda que exista. Para tal o cliente dever� fornecer o c�digo da encomenda e o c�digo do produto que ser� exclu�do da encomenda. A procedure dever� remover o item e atualizar o valor total da encomenda, do qual dever� ser subtra�do o valor do item a ser removido. A procedure poder� remover apenas um item da encomenda de cada vez.

CREATE PROCEDURE spExcluirItemEncomenda
	@codEncomenda INT
	, @codProduto INT
AS
	DECLARE @subTotal INT = (SELECT subTotal FROM tbItensEncomenda
									WHERE codProduto = @codProduto AND codEncomenda = @codEncomenda)
	IF @subTotal IS NOT NULL
	BEGIN
		DELETE FROM tbItensEncomenda 
		WHERE codProduto = @codProduto AND codEncomenda = @codEncomenda

		UPDATE tbEncomenda
			SET valorTotalEncomenda = valorTotalEncomenda - @subTotal
				WHERE codEncomenda = @codEncomenda
	END
	ELSE
	BEGIN
		PRINT('Esse item nao existe na encomenda!')
	END


EXEC spExcluirItemEncomenda 1, 10
EXEC spExcluirItemEncomenda 1, 9

/*
i) Criar  uma  stored  procedure  que  receba  o  cpf  de  um  cliente  e  a  data  de  entrega  de  uma encomenda e exclua essa encomenda feita para esse cliente. Para tal a stored procedure ter� que:
	a.Verificar se o cliente existe no banco de dados
	b.Verificar se o cliente possui encomenda na data solicitada
	c.Em caso negativo (n�o existe cliente ou n�o existe encomenda) para ambos os casos enviar mensagem informando a situa��o
	d.Em caso positivo (existe cliente e existe encomenda) excluir a encomenda e todos os seus itens do banco de dados
*/

CREATE PROCEDURE spExcluirEncomenda
	@cpfCliente CHAR(14)
	,@dataEntrega DATE
AS
	IF EXISTS (SELECT dataEntregaEncomenda FROM tbEncomenda WHERE dataEntregaEncomenda = @dataEntrega)
		BEGIN
			IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente = @cpfCliente)
				BEGIN
					DECLARE @idEncomenda INT = (SELECT codEncomenda FROM tbEncomenda
													WHERE codCliente = (SELECT codCliente FROm tbCliente WHERE cpfCliente = @cpfCliente) AND dataEntregaEncomenda = @dataEntrega)
					DELETE FROM tbItensEncomenda WHERE codEncomenda = @idEncomenda
					DELETE FROM tbEncomenda WHERE codEncomenda = @idEncomenda
					PRINT ('Encomenda excluida com sucesso')
				END
			ELSE
				PRINT ('Cliente com esse cpf nao existe')
		END
	ELSE
		PRINT ('Encomenda nao existe na data solicitada')

EXEC spExcluirEncomenda '652.624.069-04', '15/08/2015'


-- j) Criar uma stored procedure que receba uma data de entrega e que liste todas as encomendas e itens que deverao ser entregues na referida data
CREATE PROCEDURE spVerEntregasDia
	@dataEncomenda DATE
AS
	SELECT dataEntregaEncomenda 'Data de entrega', tbEncomenda.codEncomenda 'Codigo da encomenda', valorTotalEncomenda 'Valor total da encomenda' 
		,nomeProduto 'Nome do produto', nomeCliente 'Nome do cliente', ruaCliente 'Endereco do cliente', numCasaCliente 'Numero da casa', bairroCliente 'Bairro' FROM tbItensEncomenda
			INNER JOIN tbProduto ON tbProduto.codProduto = tbItensEncomenda.codProduto
				INNER JOIN tbEncomenda ON tbEncomenda.codEncomenda = tbItensEncomenda.codEncomenda
					INNER JOIN tbCliente ON tbEncomenda.codCliente = tbCliente.codCliente
						WHERE dataEntregaEncomenda = @dataEncomenda

EXEC spVerEntregasDia '2015-10-12'

