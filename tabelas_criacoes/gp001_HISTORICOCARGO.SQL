-- Folharh.tecbth_delivery.gp001_HISTORICOCARGO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_HISTORICOCARGO;

CREATE TABLE Folharh.tecbth_delivery.gp001_HISTORICOCARGO (
	cdAgenteNocivo smallint NULL,
	cdAtoPessoal smallint NULL,
	cdTipoDocumentoLegal smallint NULL,
	DtAnoDocumentoLegal smallint NULL,
	nrConcurso numeric(20,2) NULL,
	nrInscricaoConcurso varchar(20) NULL,
	nrNivelCargo smallint NULL,
	CdMatricula int NULL,
	SqContrato smallint NULL,
	DtHistorico timestamp DEFAULT timestamp NULL,
	CdMotivo smallint NULL,
	CdCargo smallint NULL,
	dtValidade timestamp DEFAULT timestamp NULL,
	cdFuncaoCargo varchar(6) NULL,
	sqVaga smallint NULL,
	nrDocumentoLegal varchar(20) NULL
);