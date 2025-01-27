-- Folharh.tecbth_delivery.gp001_ENDERECOAGENCIA definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_ENDERECOAGENCIA;

CREATE TABLE Folharh.tecbth_delivery.gp001_ENDERECOAGENCIA (
	NrBanco smallint NULL,
	NrAgencia smallint NULL,
	DsEndereco varchar(30) NULL,
	DsComplemento varchar(20) NULL,
	CdCep int NULL,
	CdLogradouro int NULL,
	NrSegmento smallint NULL,
	CdPais smallint NULL,
	cdUF smallint NULL,
	CdMunicipio numeric(20,2) NULL,
	cdBairro smallint NULL,
	NrEndereco numeric(20,2) NULL,
	dgAgencia varchar(1) NULL
);