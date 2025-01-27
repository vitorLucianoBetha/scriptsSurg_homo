-- Folharh.tecbth_delivery.gp001_HISTORICOAFASTAMENTO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_HISTORICOAFASTAMENTO;

CREATE TABLE Folharh.tecbth_delivery.gp001_HISTORICOAFASTAMENTO (
	cdCID varchar(20) NULL,
	DtGravacao timestamp DEFAULT timestamp NULL,
	CdMatricula int NOT NULL,
	SqContrato smallint NOT NULL,
	DtInicioAfastamento timestamp DEFAULT timestamp NOT NULL,
	DtFimAfastamento timestamp DEFAULT timestamp NULL,
	CdMotivoAfastamento smallint NULL,
	dsObservacao long varchar NULL,
	inParticipaSefip int NULL,
	cdEspecieBeneficioINSS smallint NULL,
	nrBeneficioINSS float NULL,
	DsObservacoes varchar(255) NULL,
	tpAcidTransito int NOT NULL,
	nmEmit varchar(60) NOT NULL,
	IdeOC int NOT NULL,
	NrOC varchar(14) NOT NULL,
	UFOC varchar(2) NOT NULL,
	InfOnusRemun int NOT NULL,
	inAfastConcomitante smallint NULL,
	nrProcJudBeneficio int NOT NULL,
	tpProcessoJudBeneficio int NOT NULL,
	codMotAfasteSocialAnt int NOT NULL,
	inGerouBeneficio smallint NOT NULL,
	UId varchar(200) NOT NULL,
	UIdAfastamentoInterrupcaoFerias varchar(200) NULL,
	AfastamentoParaInterrupcaoFerias bit NULL,
	indRemunCargo char(1) NULL,
	cnpjMandElet varchar(14) NULL,
	mtvSuspensao varchar(2) NULL,
	dsSuspensao varchar(255) NULL
);