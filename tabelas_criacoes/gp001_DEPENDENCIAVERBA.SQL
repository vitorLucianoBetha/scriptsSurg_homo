-- Folharh.tecbth_delivery.gp001_DEPENDENTEVERBA definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_DEPENDENTEVERBA;

CREATE TABLE Folharh.tecbth_delivery.gp001_DEPENDENTEVERBA (
	CdMatricula int NULL,
	SqContrato smallint NULL,
	CdDependente smallint NULL,
	CdVerba smallint NULL,
	CdPessoa numeric(20,2) NULL,
	NrIdadeLimite smallint NULL,
	CdFaixaIdade smallint NULL,
	CdFaixaCalculo smallint NULL,
	inProporcionalInicio varchar(1) NULL,
	dtSuspensao timestamp NULL
);