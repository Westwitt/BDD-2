USE bdEstoque

-- EXERC�CIO 1
INSERT INTO tbFornecedor(nomeFornecedor, contatoFornecedor)
VALUES
	('Casas Acre', 'Jo�o Carlos')
	,('Europeus', 'Hiroshi Nagaki')
	,('Bicicletafur', 'Paula Ciclistinha')


-- EXERC�CIO 2
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	INNER JOIN tbProduto ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

-- EXERC�CIO 3
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	LEFT JOIN tbProduto ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	RIGHT JOIN tbProduto ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

-- EXERC�CIO 4
INSERT INTO tbProduto(descricaoProduto, valorProduto, quantidadeProduto, codFabricante)
VALUES 
	('Tozetta', 52, 3, 3)
	,('Floormart', 154, 42, 1)
	,('Macrosoft', 12, 12, 2)
	,('Pear', 233, 54, 1)
	,('Revista Luiza', 5, 12.90, 3)

-- EXERC�CIO 5
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	FULL JOIN tbProduto ON tbProduto.codFornecedor = tbFornecedor.codFornecedor

-- EXERC�CIO 6
SELECT descricaoProduto, nomeFornecedor FROM tbProduto
	CROSS JOIN tbFornecedor

/*
	90 registros foram retornados e cada um dos produtos foi associado a cada um dos fornecedores na tabela virtual retornada.
*/