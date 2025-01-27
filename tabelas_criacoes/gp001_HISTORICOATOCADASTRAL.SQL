-- Folharh.tecbth_delivery.gp001_HISTORICOALTERACAOCADASTRAL definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_HISTORICOALTERACAOCADASTRAL;

CREATE TABLE Folharh.tecbth_delivery.gp001_HISTORICOALTERACAOCADASTRAL (
	CdMatricula int NULL,
	SqContrato smallint NULL,
	DtCompetencia timestamp NULL,
	CdAlteraCadastro smallint NULL,
	DsConteudoAnterior varchar(40) NULL
);