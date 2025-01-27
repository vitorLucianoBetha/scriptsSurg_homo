-- Folharh.tecbth_delivery.gp001_TCPR_VINCULO_EMPREGATICIO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_TCPR_VINCULO_EMPREGATICIO;

CREATE TABLE Folharh.tecbth_delivery.gp001_TCPR_VINCULO_EMPREGATICIO (
	ID int DEFAULT autoincrement NULL,
	CD_VINCULO_EMPREGATICIO smallint NULL,
	CD_TIPO_ATIVO_SIAP int NULL
);