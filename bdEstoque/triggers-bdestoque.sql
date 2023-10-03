USE bdEstoque

-- 1)

CREATE TRIGGER tgAtualizaProdutos ON tbItensVenda AFTER INSERT
AS
    DECLARE @qtProduto INT
    DECLARE @codProduto INT
    SET @qtProduto = (SELECT quantidadesItensVenda FROM INSERTED)
    SET @codProduto = (SELECT codProduto FROM INSERTED)
    UPDATE tbProduto
        SET quantidadeProduto = quantidadeProduto - @qtProduto
        WHERE codProduto = @codProduto

-- 2)

CREATE TRIGGER tgProdutoInserido ON tbEntradaProduto AFTER INSERT
AS
    DECLARE @qtProduto INT
    DECLARE @codProduto INT
    SET @qtProduto = (SELECT quantidadeEntradaProduto FROM tbEntradaProduto)
    SET @codProduto = (SELECT codProduto FROM tbEntradaProduto)
    UPDATE tbProduto
        SET quantidadeProduto = quantidadeProduto + @qtProduto
            WHERE codProduto = @codProduto

-- 3)

CREATE TRIGGER tgInsertSaidaProduto ON tbItensVenda AFTER INSERT
AS
    DECLARE @qtProduto INT
    DECLARE @codProduto INT
    SET @qtProduto = (SELECT quantidadeEntradaProduto FROM tbEntradaProduto)
    SET @codProduto = (SELECT codProduto FROM tbEntradaProduto)
    INSERT INTO tbSaidaProduto(dataSaidaProduto, quantidadeSaidaProduto, codProduto)
    VALUES
        (GETDATE(), @qtProduto, @codProduto)