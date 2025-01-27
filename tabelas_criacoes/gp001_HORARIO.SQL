-- Folharh.tecbth_delivery.gp001_HORARIO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_HORARIO;

CREATE TABLE Folharh.tecbth_delivery.gp001_HORARIO (
	CdHorario smallint NULL,
	dsHorario varchar(50) NULL,
	CdTurno smallint NULL,
	HrEntrada smallint NULL,
	HrSaida smallint NULL,
	HrInicioIntervalo smallint NULL,
	HrFimIntervalo smallint NULL,
	nrHorasDiurnas numeric(20,2) NULL,
	nrHorasNoturnas numeric(20,2) NULL,
	nrHorasDiurnasExcede numeric(20,2) NULL,
	nrHorasNoturnasExcede numeric(20,2) NULL,
	InHorarioFlexivel int NULL,
	InIntervaloJornada int NULL
);