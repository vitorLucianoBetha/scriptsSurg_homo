-- Folharh.tecbth_delivery.gp001_DEPENDENTE definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_DEPENDENTE;

CREATE TABLE Folharh.tecbth_delivery.gp001_DEPENDENTE (
	cdMotivoFimRelacao smallint NULL,
	cdMotivoInicioRelacao smallint NULL,
	cdPessoaDependente numeric(20,2) NULL,
	DtFimRelacao timestamp DEFAULT timestamp NULL,
	DtInicioRelacao timestamp DEFAULT timestamp NULL,
	CdPessoa numeric(20,2) NULL,
	CdDependente smallint NULL,
	CdGrauDependencia smallint NULL,
	InEstuda smallint NULL,
	InTrabalha smallint NULL,
	incTrab int NULL,
	incFisMen smallint NULL,
	i_dependentes int NULL
);