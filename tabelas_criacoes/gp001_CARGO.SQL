-- Folharh.tecbth_delivery.gp001_CARGO definition

-- Drop table

-- DROP TABLE Folharh.tecbth_delivery.gp001_CARGO;

CREATE TABLE Folharh.tecbth_delivery.gp001_CARGO (
	cdAtoPessoal smallint NULL,
	cdCboCargo int NULL,
	cdCboCargo94 varchar(5) NULL,
	cdGrupoCboCargo int NULL,
	cdGrupoCboCargo94 varchar(3) NULL,
	cdTipoDocumentoLegal smallint NULL,
	DtAnoDocumentoLegal smallint NULL,
	CdCargo smallint NULL,
	DsCargo varchar(30) NULL,
	CdCargoPromocao smallint NULL,
	NrLeiCargo varchar(15) NULL,
	DtLeiCargo timestamp NULL,
	QTVAGAS_Old int NULL,
	nrMesesPromocao smallint NULL,
	TpCargo smallint NULL,
	cdCargoGrupo smallint NULL,
	cdEstruturaSalarialPromocao smallint NULL,
	cdGrupoFaixaSalarialPromocao smallint NULL,
	nrSequenciaFaixaPromocao smallint NULL,
	sgCargo varchar(8) NULL,
	CdTribunal int NULL,
	dtDesativacao timestamp NULL,
	inQuadroVagas_Old smallint NULL,
	nmCargo varchar(256) NULL,
	nrDocumentoLegal varchar(20) NULL,
	nrCargaHoraria smallint NULL,
	acumCargo int NULL,
	contagemEsp int NULL,
	dedicExcl int NULL,
	nrDocumentoLegalExtincao varchar(20) NULL,
	nrLeiCargoExtincao varchar(15) NULL,
	CdTpProvimento int NULL,
	cdTipoDocumentoLegalExtincao smallint NULL,
	dtAnoDocumentoLegalExtincao smallint NULL,
	sqMovimentoAtoExtincao smallint NULL,
	sqMovimentoAto smallint NULL,
	ID int DEFAULT autoincrement NULL
);