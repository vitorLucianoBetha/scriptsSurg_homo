-- Folharh.tecbth_delivery.gp001_MOVIMENTOFIXO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_MOVIMENTOFIXO;

CREATE TABLE Folharh.tecbth_delivery.gp001_MOVIMENTOFIXO (
	in13Slr smallint NULL,
	inFerias smallint NULL,
	inIncidencia smallint NULL,
	CdMatricula int NULL,
	SqContrato smallint NULL,
	CdVerba smallint NULL,
	TpCalculo smallint NULL,
	DtInicioMovto timestamp NULL,
	VlMovimento numeric(20,2) NULL,
	NrOcorrencia smallint NULL,
	NrOcorrido smallint NULL,
	InSuspenso varchar(1) NULL,
	vlSimulado numeric(20,2) NULL,
	dtInicioSimulado timestamp NULL,
	DtInicioValidade timestamp NULL,
	DtFinalValidade timestamp NULL,
	vlAnterior numeric(20,2) NULL,
	inVlIntegralProp smallint NULL,
	inRescisao smallint NULL,
	nrCPF numeric(20,2) NULL,
	DsObservacoes varchar(255) NULL,
	DsComplemento varchar(8) NULL
);