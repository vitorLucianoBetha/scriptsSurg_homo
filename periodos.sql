if  exists (select 1 from sys.sysprocedure where creator = (select user_id from sys.sysuserperms where user_name = current user) and proc_name = 'cnv_periodos') then
	drop procedure cnv_periodos;
end if
;

begin
	// *****  Tabela bethadba.periodos
	declare w_i_funcionarios integer;
	declare w_i_periodos smallint;
	declare w_dt_previsao date;
	declare w_num_dias_abono integer;
	
	// *****  Tabela bethadba.periodos_ferias
	declare w_dt_admissao date;
	-- BUG BTHSC-8157 Migrou intervalo de período aquisitivo de férias errado
	ooLoop: for oo as cnv_periodos dynamic scroll cursor for
		select 1 as w_i_entidades, cdMatricula  as w_cdMatricula,SqContrato as w_SqContrato,NrPeriodo as w_NrPeriodo,date(DtInicioPeriodo) as w_dt_aquis_ini,date(DtFimPeriodo) as w_DtFimPeriodo,
			   NrDiasFeriasDireito as w_num_dias_dir,date(DtInicioSuspensao) as w_dt_inicial,date(DtFimSuspensao) as w_dt_final,NrDiasPerdeAfastamento as w_num_dias,
			   nrDiasAbonoDireito as w_nrDiasAbonoDireito,date(DtFimPeriodo) as w_dt_aquis_fin,date(DtInicioPeriodo) as w_dt_periodo
		from tecbth_delivery.gp001_PeriodoAquisicao 
		order by 1,2,3,5 asc	
	do
		
		// *****  Inicializa Variaveis
		set w_i_funcionarios = null;
		set w_i_periodos = null;
		set w_dt_previsao = null;
		set w_num_dias_abono = null;		
		set w_dt_admissao = null;
		
		if w_nrDiasAbonoDireito is not null and w_nrDiasAbonoDireito >= 0 then
			set w_num_dias_abono=w_nrDiasAbonoDireito
		else
			set w_num_dias_abono=0
		end if;
		
		// ***** converte bethadba.periodos
		set w_i_funcionarios=cast(w_cdMatricula as integer);
		
		select dt_admissao 
		into w_dt_admissao 
		from bethadba.funcionarios 
		where i_entidades = w_i_entidades 
		and i_funcionarios = w_i_funcionarios;
		
		if w_DtFimPeriodo > w_dt_admissao then
			select coalesce(max(i_periodos),0)+1 
			into w_i_periodos 
			from bethadba.periodos 
			where i_entidades = w_i_entidades 
			and i_funcionarios = w_i_funcionarios;
			
			set w_dt_previsao=w_dt_aquis_fin+1;
		
			if exists(select 1 from bethadba.funcionarios where	i_entidades = w_i_entidades and	i_funcionarios = w_i_funcionarios) then
				if not exists(select 1 from bethadba.periodos where	i_entidades = w_i_entidades and	i_funcionarios = w_i_funcionarios and dt_aquis_ini = w_dt_aquis_ini) then
					message 'Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Per.: '||w_i_periodos||' Dt. Ini.: '||w_dt_aquis_ini||' Dt Fin.: '||w_dt_aquis_fin to client;
				
					insert into bethadba.periodos(i_entidades,i_funcionarios,i_periodos,dt_aquis_ini,dt_aquis_fin,num_dias_dir,dt_previsao,num_dias_abono)on existing skip
					values (w_i_entidades,w_i_funcionarios,w_i_periodos,w_dt_aquis_ini,w_dt_aquis_fin,w_num_dias_dir,w_dt_previsao,w_num_dias_abono);
				
					insert into bethadba.periodos_ferias(i_entidades,i_funcionarios,i_periodos,i_periodos_ferias,tipo,dt_periodo,num_dias,observacao,manual,i_ferias,i_rescisoes)on existing skip
					values (w_i_entidades,w_i_funcionarios,w_i_periodos,1,1,w_dt_periodo,30,null,'S',null,null);
				
					if (w_dt_final - w_dt_inicial) >= 180 then					
						message 'Cancelamento Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Per.: '||w_i_periodos to client;
						
						insert into bethadba.periodos_ferias(i_entidades,i_funcionarios,i_periodos,i_periodos_ferias,tipo,dt_periodo,num_dias,observacao,manual,i_ferias,i_rescisoes)on existing skip
						values (w_i_entidades,w_i_funcionarios,w_i_periodos,2,5,w_dt_aquis_fin,w_num_dias,'Período cancelado pelo afastamento maior que 180 dias. Período de afastamento: '||w_dt_inicial||' até '||w_dt_final||'.',
								'S',null,null);
						
						message 'Suspensão Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Per.: '||w_i_periodos||' Dt. Ini.: '||w_dt_inicial||' Dt Fin.: '||w_dt_final to client;
						
						insert into bethadba.susp_periodos(i_entidades,i_funcionarios,i_periodos,dt_inicial,dt_final,observacao)on existing skip
						values (w_i_entidades,w_i_funcionarios,w_i_periodos,w_dt_inicial,w_dt_final,'Período cancelado pelo afastamento maior que 180 dias. Período de afastamento: '||w_dt_inicial||' até '||w_dt_final||'.');
					end if;
					
					if w_dt_inicial is not null and w_dt_final is not null then
						message 'Suspensão Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Per.: '||w_i_periodos||' Dt. Ini.: '||w_dt_inicial||' Dt Fin.: '||w_dt_final to client;
						
						insert into bethadba.susp_periodos(i_entidades,i_funcionarios,i_periodos,dt_inicial,dt_final,observacao)on existing skip
						values (w_i_entidades,w_i_funcionarios,w_i_periodos,w_dt_inicial,w_dt_final,null);
					end if;
				end if;
			end if;
		end if;
		
	end for;
end;


-- importar a tabela  e apos isso fazer os ajustes
/****** Script do comando SelectTopNRows de SSMS 
SELECT *
  FROM [GP0001_FHOMUV].[dbo].[PERIODOCONCESSAO]
  
  
update testedie
set DtPagamento= null
where DtPagamento = 'NULL'

/*
    ******/
rollback;
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit','on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;


-- DDL generated by DBeaver
-- WARNING: It may differ from actual native database DDL
CREATE TABLE tecbth_delivery.gp001_PERIODOCONCESSAO (
	inFeriasProporcional smallint NULL,
	inMediaProporcional smallint NULL,
	inPagarComoAdto int NULL,
	inPgtoMediaAbono smallint NULL,
	inVerbasProcesso20 smallint NULL,
	CdMatricula int NULL,
	SqContrato smallint NULL,
	NrPeriodo smallint NULL,
	DtInicioPeriodo datetime NULL,
	DtInicioConcessao datetime NULL,
	DtFimConcessao datetime NULL,
	NrDiasFeriasConcedidas numeric(20,2) NULL,
	NrDiasAbonoConcedidas numeric(20,2) NULL,
	NrDiasConcedidasPeriodo numeric(20,2) NULL,
	InTipoConcessao varchar(1) NULL,
	InSituacaoConcessao varchar(1) NULL,
	DtPagamento datetime NULL,
	inPgto13Salario varchar(1) NULL,
	inPgtoFerias varchar(1) NULL,
	inPgtoAbono varchar(1) NULL,
	inPgtoMediaFerias varchar(1) NULL,
	inPgtoSalarioMesFerias varchar(1) NULL,
	vlPercTercoFerias numeric(20,2) NULL,
	vlPercTercoAbono numeric(20,2) NULL,
	vlPercTercoMedia numeric(20,2) NULL,
	vlPerc13Salario numeric(20,2) NULL,
	vlBaseFerias numeric(20,2) NULL,
	vlBaseMedia numeric(20,2) NULL,
	SqHabilitacaoFicha smallint NULL,
	CdTipoMedia smallint NULL,
	InPagtoFolha varchar(1) NULL,
	DtPgtoFolha datetime NULL,
	InTransicaoVerbas varchar(1) NULL,
	InColetivo smallint NULL,
	inReciboFeriasEmitido varchar(10) NULL,
	vlBaseFeriasRecibo numeric(20,2) NULL,
	vlBaseFerias1Mes numeric(20,2) NULL,
	vlBaseFeriasPeriodo numeric(20,2) NULL,
	vlBaseMediaRecibo numeric(20,2) NULL,
	vlBaseMedia1Mes numeric(20,2) NULL,
	vlBaseMediaPeriodo numeric(20,2) NULL,
	vlFerias numeric(20,2) NULL,
	vlFeriasTerco numeric(20,2) NULL,
	vlAbono numeric(20,2) NULL,
	vlAbonoTerco numeric(20,2) NULL,
	vlMedia numeric(20,2) NULL,
	vlMediaTerco numeric(20,2) NULL,
	vlTotalFerRecibo numeric(20,2) NULL,
	vlTotalFer1Mes numeric(20,2) NULL,
	vlTotalFerPeriodo numeric(20,2) NULL,
	vlTotalFerAnterior numeric(20,2) NULL,
	vlTotalAbonoRecibo numeric(20,2) NULL,
	vlTotalAbono1Mes numeric(20,2) NULL,
	vlTotalAbonoPeriodo numeric(20,2) NULL,
	vlTotalAbonoAnterior numeric(20,2) NULL,
	vlDiferencaFerias numeric(20,2) NULL,
	vlDiferencaAbono numeric(20,2) NULL,
	inMediaAbonoSeparado smallint NULL,
	inPagaAdtoAnalitico smallint NULL,
	inSituacaoAnalitico smallint NULL,
	inSituacaoOrigem varchar(1) NULL,
	dtInterrupcao datetime NULL,
	dsMotivoInterrupcao varchar(50) NULL,
	inTipoPeriodo varchar(1) NULL,
	inTipoPeriodoAuxTemp varchar(1) NULL,
	inVerbasProcesso38 smallint NULL,
	IN_PAGAADIANTAMENTOLIQUIDO smallint NULL,
	DsObservacoes varchar(255) NULL,
	FL_VERBAS_INTEGRAL_RECIBO_PROP_FOLHA smallint NULL,
	inTemDoisPeriodos smallint NULL,
	InPagtoFeriasDobro int NULL,
	inTransitarIntegMesInicio smallint NULL,
	IdMovtoAtoLegalInt int NULL,
	UId char(36) NULL
);
