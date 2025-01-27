-- Folharh.tecbth_delivery.gp001_HISTORICOSALARIAL definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_HISTORICOSALARIAL;

CREATE TABLE Folharh.tecbth_delivery.gp001_HISTORICOSALARIAL (
	nrNivelCargo smallint NULL,
	CdMatricula int NULL,
	SqContrato smallint NULL,
	CdCargo smallint NULL,
	cdFuncaoCargo varchar(6) NULL,
	DtHistorico timestamp DEFAULT timestamp NULL,
	inSimulado smallint NULL,
	CdMotivo smallint NULL,
	inMovtoFuncao smallint NULL,
	TpPagamento varchar(1) NULL,
	VlSalarioFaixa numeric(19,4) NULL,
	VlSalario numeric(19,4) NULL,
	dtFinalValidadeSalario timestamp DEFAULT timestamp NULL,
	dtInicioValidadeSalario timestamp DEFAULT timestamp NULL,
	dtValidade timestamp DEFAULT timestamp NULL,
	dtFinalValidade timestamp DEFAULT timestamp NULL,
	cdIndicadorSalarioFixo smallint NULL,
	cdIndicadorSalarioFaixa smallint NULL,
	vlCotacaoIndicadorFixo numeric(20,2) NULL,
	vlCotacaoIndicadorFaixa numeric(20,2) NULL,
	cdEstruturaSalarial smallint NULL,
	cdGrupoFaixaSalarial smallint NULL,
	dtGravacao timestamp DEFAULT timestamp NULL,
	nrHorasSalarioFaixa smallint NULL,
	nrSequenciaFaixa smallint NULL,
	InSistema varchar(1) NULL,
	DtGeracao timestamp DEFAULT timestamp NULL,
	IdCalculoRetroFuncionarioPagto int NULL
);