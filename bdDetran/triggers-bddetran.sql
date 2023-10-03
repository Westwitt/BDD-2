USE bdDetran
SET DATEFORMAT DMY;

-- 1
CREATE TRIGGER tgTomarMulta ON tbMulta AFTER INSERT
AS
    DECLARE @pontosMulta TINYINT = (SELECT numPontos FROM INSERTED)
    DECLARE @codMulta INT = (SELECT codMulta FROM INSERTED)

    DECLARE @codMotorista INT = (SELECT codMotorista FROM tbMulta
                                    JOIN tbVeiculo ON tbVeiculo.codVeiculo = tbMulta.codVeiculo
                                        WHERE codMulta = @codMulta)

    UPDATE tbMotorista
        SET pontuacaoAcumulada = pontuacaoAcumulada + @pontosMulta
            WHERE codMotorista = @codMotorista

    PRINT('O motorista de codigo '+CONVERT(VARCHAR(5), @codMotorista)+' teve sua pontuacao alterada, pois tomou uma multa de '+CONVERT(VARCHAR(5), @pontosMulta)+' pontos')

INSERT INTO tbMulta(dataMulta, numPontos, codVeiculo)
VALUES
    ('17/09/2023', 12, 5)

select * from tbMotorista
select * from tbMulta


-- 2
CREATE TRIGGER tgSuspender ON tbMotorista AFTER UPDATE
AS
        DECLARE @codMotorista INT = (SELECT inserted.codMotorista FROM inserted INNER JOIN deleted ON inserted.codMotorista = deleted.codMotorista)
        DECLARE @pontos INT = (SELECT inserted.pontuacaoAcumulada FROM inserted INNER JOIN deleted ON inserted.codMotorista = deleted.codMotorista)
        IF (@pontos>=20)
        BEGIN
            PRINT('Cliente '+CONVERT(VARCHAR(5), @codMotorista)+' foi suspenso por atingir 20 pontos ou mais.')
            UPDATE tbMotorista 
                SET situacao = 'SUSPENSO'
                    WHERE codMotorista = @codMotorista
        END