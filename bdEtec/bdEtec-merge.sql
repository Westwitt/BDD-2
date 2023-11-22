USE bdEtec

MERGE tbTerceiro dest
	USING (SELECT * FROM tb2A WHERE statusAluno = 'Aprovado') ori
	ON ori.rmAluno = dest.rmAluno
	WHEN NOT MATCHED THEN
		INSERT VALUES (ori.rmAluno, ori.nomeAluno, ori.statusAluno);

MERGE tbTerceiro dest
	USING (SELECT * FROM tb2B WHERE statusAluno = 'Aprovado') ori
	ON ori.rmAluno = dest.rmAluno
	WHEN NOT MATCHED THEN
		INSERT VALUES (ori.rmAluno, ori.nomeAluno, ori.statusAluno);

SELECT * FROM tbTerceiro