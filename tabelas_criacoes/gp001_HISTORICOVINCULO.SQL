-- Folharh.tecbth_delivery.gp001_HISTORICOVINCULO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_HISTORICOVINCULO;

CREATE TABLE Folharh.tecbth_delivery.gp001_HISTORICOVINCULO (
	cdMatricula int NULL,
	sqContrato smallint NULL,
	dtInicio timestamp DEFAULT timestamp NULL,
	cdVinculoEmpregaticio smallint NULL
);