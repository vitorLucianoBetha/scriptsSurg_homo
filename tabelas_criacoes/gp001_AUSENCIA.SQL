-- Folharh.tecbth_delivery.gp001_AUSENCIA definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_AUSENCIA;

CREATE TABLE Folharh.tecbth_delivery.gp001_AUSENCIA (
	cdAusencia smallint NULL,
	dsAusencia varchar(25) NULL,
	inPerdeValeTransporte varchar(1) NULL,
	inPerdeTempoServico varchar(1) NULL,
	inPerdeFerias varchar(1) NULL,
	inPerde13Sal varchar(1) NULL,
	inPerdeRepouso varchar(1) NULL,
	inPerdeFeriado varchar(1) NULL,
	InPagaProporcionalV varchar(1) NULL,
	inPagaProporcional varchar(1) NULL,
	inPerdeAdiantamento varchar(1) NULL,
	InDeduzHorasTrab varchar(1) NULL,
	inAvaliacao varchar(1) NULL,
	qtLimiteFaltas int NULL,
	dtLimiteFaltas timestamp NULL,
	inBloqueioMvtoFalta varchar(1) NULL,
	cdVerbaHorasDia smallint NULL,
	cdVerbaHorasExced smallint NULL,
	cdVerbaHorasNot smallint NULL,
	cdVerbaHorasNotExced smallint NULL,
	inContaAte31 smallint NULL,
	inContaFevAte30 smallint NULL,
	qtLimiteFaltasMes int NULL
);