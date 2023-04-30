USE bdLivrariaBrasileira

-- a) O total de livros que começam com a letra P
SELECT count(codLivro) AS 'Quantidade de livros que começam com a letra P' FROM tbLivro
	WHERE nomeLivro LIKE 'p%'

-- c) O menor número de páginas entre todos os livros
SELECT min(numPaginas) AS 'A menor quantidade de páginas que um livro possui' FROM tbLivro

-- e) A soma do número de páginas dos livros de editora código 01
SELECT sum(numPaginas) AS 'Total de paginas dos livros da editora Melhoramentos' FROM tbLivro
	WHERE codEditora = 1

-- g) A média dos números de páginas dos livros que sejam do autor código 03
SELECT avg(numPaginas) AS 'Média do número de páginas da autora J.K. Rowling' FROM tbLivro
	WHERE codAutor = 3

-- i) A média do número de páginas dos livros que tenham a palavra “estrela” em seu nome
SELECT avg(numPaginas) AS 'Média do número de páginas que possuem "estrela" em seu nome' FROM tbLivro	
	WHERE nomeLivro LIKE '%estrela%'

-- k) A quantidade de livros agrupado pelo nome do gênero
SELECT nomeGenero, count(codLivro) AS 'Quantidade de livros' FROM tbLivro
	RIGHT JOIN tbGenero ON tbLivro.codGenero = tbGenero.codGenero
		GROUP BY nomeGenero

-- m) A média de páginas agrupada pelo nome do autor em ordem alfabética (de A a Z) (EXERCICIO 13) (EXERCICIO 13) (EXERCICIO 13) (EXERCICIO 13) (EXERCICIO 13)
SELECT nomeAutor, avg(numPaginas) AS 'Média do número de páginas' FROM tbLivro
	RIGHT JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		GROUP BY nomeAutor

-- o) A soma de páginas dos livros agrupados pelo nome do autor que sejam de autores cujo nome comece com a letra “C”
SELECT nomeAutor, sum(numPaginas) AS 'Soma do número de páginas' FROM tbLivro
	RIGHT JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		WHERE nomeAutor LIKE 'C%'
			GROUP BY nomeAutor

-- q) A soma das páginas dos livros agrupadas pelo nome da editora cujo número de páginas esteja entre 200 e 500 (inclusive)
SELECT nomeEditora, sum(numPaginas) AS 'Soma do número de páginas' FROM tbLivro
	RIGHT JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
		WHERE numPaginas BETWEEN 200 and 500
			GROUP BY nomeEditora

-- s) O nome dos livros ao lado do nome do autor somente daqueles cujo nome da editora for “Cia das Letras”
SELECT nomeLivro, nomeAutor FROM tbLivro
	JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		JOIN tbEditora ON tbLivro.codEditora = tbEditora.codEditora
			WHERE nomeEditora = 'Cia das Letras'

-- u) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles autores que não tem livros cadastrados
SELECT nomeAutor, nomeLivro FROM tbAutor
	LEFT JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor

-- w) O nome dos autores ao lado dos nomes dos livros, indiferente do autor ter ou não livro publicado, e indiferente do livro pertencer a algum autor
SELECT nomeAutor, nomeLivro FROM tbLivro
	FULL JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor

-- y) Somente os nomes dos autores que não tem livros cadastrados
SELECT nomeAutor FROM tbAutor
	LEFT JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor
		WHERE tbLivro.codAutor IS NULL