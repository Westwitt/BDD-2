USE bdEstoque

-- 1) Criar uma consulta que retorne o código do produto, o nome do produto e o nome do fabricante somente daqueles produtos que custam igual ao valor mais alto;
SELECT codProduto, descricaoProduto, nomeFabricante FROM tbProduto
	JOIN tbFabricante ON tbProduto.codFabricante = tbFabricante.codFabricante
		WHERE valorProduto = (SELECT max(valorProduto) FROM tbProduto)

-- 2) Criar uma consulta que retorne o nome do produto e o nome do fabricante e o valor somente dos produtos que custem acima do valor médio dos produtos em estoque
SELECT descricaoProduto, valorProduto, nomeFabricante FROM tbProduto
	JOIN tbFabricante ON tbProduto.codFabricante = tbFabricante.codFabricante
		WHERE valorProduto >= (SELECT avg(valorProduto) FROM tbProduto)

-- 3) Criar uma consulta que retorne o nome dos clientes que tiveram vendas com valor acima do valor médio das vendas
SELECT nomeCliente FROM tbCliente
	JOIN tbVenda ON tbCliente.codCliente = tbVenda.codCliente
		WHERE valorTotalVenda > (SELECT avg(valorTotalVenda) FROM tbVenda)

-- 4) Criar uma consulta que retorno o nome e o preço dos produtos mais caros
SELECT descricaoProduto, valorProduto FROM tbProduto
	WHERE valorProduto = (SELECT max(valorProduto) FROM tbProduto)

-- 5) Criar uma consulta que retorne o nome e o preço do produto mais barato
SELECT descricaoProduto, valorProduto FROM tbProduto
	WHERE valorProduto = (SELECT min(valorProduto) FROM tbProduto)