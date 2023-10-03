USE bdDetran

INSERT INTO tbMotorista(nomeMotorista, cpfMotorista, pontuacaoAcumulada, situacao)
VALUES
    ('Balan Sarrola', '486.655.690-06', 0, 'NORMAL')
    , ('Cuca Areka', '709.343.050-30', 0, 'NORMAL')
    , ('Balão Suspeito', '146.164.600-60', 0, 'NORMAL')
    , ('Bruxo Passeios', '520.611.210-04', 0, 'NORMAL')
    , ('Kemel Pinto', '014.113.580-82', 0, 'NORMAL')
    , ('Paula Dentro', '258.777.400-40', 0, 'NORMAL')

INSERT INTO tbVeiculo(placaVeiculo, renavam, anoFabricacao, codMotorista)
VALUES
    ('CMV-7111', '98393889476', '2012', 1)
    , ('DNZ-9811', '12238853520', '2000', 2)
    , ('CVL-9517', '35363437382', '2023', 3)
    , ('BNO-9763', '39442799492', '2017', 4)
    , ('EKO-3414', '93863847986', '2019', 5)
    , ('BLX-4062', '32332439249', '2006', 6)