-- Folharh.tecbth_delivery.gp001_HISTORICOLOTACAO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_HISTORICOLOTACAO;

CREATE TABLE Folharh.tecbth_delivery.gp001_HISTORICOLOTACAO (
	cdAgenteNocivo smallint NULL,
	CdMatricula int NULL,
	SqContrato smallint NULL,
	DtTransferencia timestamp DEFAULT timestamp NULL,
	TpTransferencia varchar(1) NULL,
	CdMatriculaTransf int NULL,
	SqContratoTransf smallint NULL,
	CdTipoAdmissao smallint NULL,
	CdTipoDesligamento smallint NULL,
	CdEmpresaTransf smallint NULL,
	CdFilialTransf smallint NULL,
	CdLocalTransf smallint NULL,
	inTransferencia varchar(1) NULL,
	inServico varchar(1) NULL
);