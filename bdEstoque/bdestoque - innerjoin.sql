-- A
SELECT descricaoProduto, nomeFabricante FROM tbProduto
	INNER JOIN tbFabricante ON tbProduto.codfabricante = tbFabricante.codFabricante

-- B
SELECT descricaoProduto, nomeFornecedor FROM tbProduto
	INNER JOIN tbFornecedor ON tbProduto.codFornecedor = tbFornecedor.codFornecedor

-- C
SELECT nomeFabricante, SUM(quantidadeProduto) 'Quantidade' FROM tbFabricante
	INNER JOIN tbProduto ON tbFabricante.codFabricante = tbProduto.codFabricante
		GROUP BY nomeFabricante

-- D
SELECT nomeCliente, SUM(valorTotalVenda) 'Valor total' FROM tbCliente
	INNER JOIN tbVenda ON tbCliente.codCliente = tbVenda.codCliente
		GROUP BY nomeCliente
			ORDER BY [Valor total]

-- E
SELECT AVG(valorProduto) 'Media dos valores', nomeFornecedor FROM tbProduto
	INNER JOIN tbFornecedor ON tbProduto.codFornecedor = tbFornecedor.codFornecedor
		GROUP BY nomeFornecedor

-- F
SELECT nomeCliente, SUM(valorTotalVenda) 'Valor total venda' FROM tbCliente	
	INNER JOIN tbVenda ON tbVenda.codCliente = tbCliente.codCliente
		GROUP BY nomeCliente
			ORDER BY nomeCliente

-- G
SELECT nomeFabricante, SUM(valorProduto) 'Soma dos precos de cada produto' FROM tbFabricante
	INNER JOIN tbProduto ON tbProduto.codFabricante = tbFabricante.codFabricante
		GROUP BY nomeFabricante

-- H
SELECT nomeFornecedor, AVG(valorProduto) 'Media dos valores dos produtos' FROM tbFornecedor
	INNER JOIN tbProduto ON tbProduto.codFornecedor = tbFornecedor.codFornecedor
		GROUP BY nomeFornecedor

-- I
SELECT descricaoProduto, SUM(quantidadesItensVenda) 'qtd vendidos' FROM tbProduto
	INNER JOIN tbItensVenda ON tbItensVenda.codProduto = tbProduto.codProduto
		GROUP BY descricaoProduto

-- J
SELECT nomeCliente, SUM(valorTotalVenda) 'Valor total venda' FROM tbCliente	
	INNER JOIN tbVenda ON tbVenda.codCliente = tbCliente.codCliente
		WHERE MONTH(dataVenda) = '2' AND YEAR(dataVenda) = '2014'
			GROUP BY nomeCliente
				ORDER BY nomeCliente