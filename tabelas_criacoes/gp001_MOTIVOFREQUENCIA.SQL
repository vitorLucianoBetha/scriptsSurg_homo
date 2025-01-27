-- Folharh.tecbth_delivery.gp001_MOVIMENTOFREQUENCIA definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_MOVIMENTOFREQUENCIA;

CREATE TABLE Folharh.tecbth_delivery.gp001_MOVIMENTOFREQUENCIA (
	CdMatricula int NULL,
	inSituacao varchar(1) NULL,
	SqContrato smallint NULL,
	CdAusencia smallint NULL,
	DtInicio timestamp DEFAULT timestamp NULL,
	DtFim timestamp DEFAULT timestamp NULL,
	nrDias smallint NULL,
	nrHorasDiurnas numeric(20,2) NULL,
	nrHorasNoturnas numeric(20,2) NULL,
	nrHorasExcedeDiurnas numeric(20,2) NULL,
	nrHorasExcedeNoturnas numeric(20,2) NULL,
	DsObservacoes varchar(255) NULL
);