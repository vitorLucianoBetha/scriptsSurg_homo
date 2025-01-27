-- Folharh.tecbth_delivery.gp001_ORGANOGRAMA definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_ORGANOGRAMA;

CREATE TABLE Folharh.tecbth_delivery.gp001_ORGANOGRAMA (
	cdOrganograma smallint NULL,
	inAtualiza smallint NULL,
	dsOrganograma varchar(50) NULL,
	nrNivelFilial smallint NULL,
	inVincularTodosLocais smallint NULL,
	dsMascara varchar(60) NULL,
	inOrganogramaContabil smallint NULL,
	cdIndicadorFuncional smallint NULL,
	DT_INICIO_PRINCIPAL timestamp DEFAULT timestamp NULL
);