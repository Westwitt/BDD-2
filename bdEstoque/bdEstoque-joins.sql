USE bdEstoque

-- EXERCÍCIO 1
INSERT INTO tbFornecedor(nomeFornecedor, contatoFornecedor)
VALUES
	('Casas Acre', 'João Carlos')
	,('Europeus', 'Hiroshi Nagaki')
	,('Bicicletafur', 'Paula Ciclistinha')


-- EXERCÍCIO 2
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	INNER JOIN tbProduto ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

-- EXERCÍCIO 3
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	LEFT JOIN tbProduto ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	RIGHT JOIN tbProduto ON tbFornecedor.codFornecedor = tbProduto.codFornecedor

-- EXERCÍCIO 4
INSERT INTO tbProduto(descricaoProduto, valorProduto, quantidadeProduto, codFabricante)
VALUES 
	('Tozetta', 52, 3, 3)
	,('Floormart', 154, 42, 1)
	,('Macrosoft', 12, 12, 2)
	,('Pear', 233, 54, 1)
	,('Revista Luiza', 5, 12.90, 3)

-- EXERCÍCIO 5
SELECT nomeFornecedor, descricaoProduto FROM tbFornecedor
	FULL JOIN tbProduto ON tbProduto.codFornecedor = tbFornecedor.codFornecedor

-- EXERCÍCIO 6
SELECT descricaoProduto, nomeFornecedor FROM tbProduto
	CROSS JOIN tbFornecedor

/*
	90 registros foram retornados e cada um dos produtos foi associado a cada um dos fornecedores na tabela virtual retornada.
*/