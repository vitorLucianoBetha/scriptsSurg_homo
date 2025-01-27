
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;

-------------------------------------------------  

insert into bethadba.motivos_faltas(i_motivos_faltas,descricao,justificada,perde_temposerv,previsao,impacta_ferias)on existing skip
select cdAusencia+4,dsAusencia,if cdAusencia = 2 then 
								 'N' 
							   else 
							     'S' 
							   endif, 
	   inPerdeTempoServico,null,null 
from tecbth_delivery.gp001_ausencia 
order by 1 asc
;

commit
;


begin
	// *****  Tabela bethadba.faltas
	declare w_i_funcionarios integer;
	declare w_tipo_faltas char(1);
	declare w_qtd_faltas decimal(7,4);
	declare w_i_motivos_faltas smallint;
	declare w_comp_descto date;
	declare w_i_faltas integer;
	
	ooLoop: for oo as cnv_faltas dynamic scroll cursor for
		select 1 as w_i_entidades,cdMatricula as w_CdMatricula,SqContrato as w_SqContrato,CdAusencia+4 as w_CdAusencia,date(DtInicio) as w_dt_inicial,DtFim as w_DtFim,nrDias as w_nrDias,
			   nrHorasDiurnas as w_nrHorasDiurnas,InSituacao as w_InSituacao 
		from tecbth_delivery.gp001_MovimentoFrequencia as MovimentoFrequencia
	do
		
		// *****  Inicializa as variaveis
		set w_i_funcionarios=null;
		set w_tipo_faltas=null;
		set w_qtd_faltas=null;
        set w_i_entidades = 1;
		set w_i_motivos_faltas=null;
		set w_comp_descto=null;
		set w_i_faltas = null; 
		
		// *****  Converte tabela bethadba.faltas
		set w_i_funcionarios=cast(w_cdMatricula as integer);
		
		if w_InSituacao = 'D' then
			set w_tipo_faltas=1;
			set w_qtd_faltas=w_nrDias;
			
			if w_qtd_faltas = 0 then
				set w_tipo_faltas=2;
				set w_qtd_faltas=w_nrHorasDiurnas
			end if
		else
			set w_tipo_faltas=2;
			set w_qtd_faltas=w_nrHorasDiurnas;
		
			if w_qtd_faltas = 0 then
				set w_tipo_faltas=1;
				set w_qtd_faltas=1
			end if
		end if;
		
		if w_CdAusencia = 0 then
			set w_i_motivos_faltas=7
		else
			set w_i_motivos_faltas=w_CdAusencia
		end if;
		
		set w_comp_descto=ymd(year(w_dt_inicial),month(w_dt_inicial),'01');

		
		select coalesce(max(i_faltas)+1,1)
		into w_i_faltas 
		from bethadba.faltas 
		where i_entidades = w_i_entidades 
		and i_funcionarios = w_i_funcionarios; 
		
		if exists(select 1 from bethadba.funcionarios where i_entidades = w_i_entidades and i_funcionarios = w_i_funcionarios) then
			message 'Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Dt.: '||w_dt_inicial||' Qtd.: '||w_qtd_faltas to client;
			
			insert into bethadba.faltas(i_entidades,i_funcionarios,dt_inicial,tipo_faltas,qtd_faltas,i_motivos_faltas,tipo_descto,comp_descto,i_atestados,abonada,comp_abono,qtd_abono,
										motivo_abono,periodo_ini_falta,i_faltas) 
			values (w_i_entidades,w_i_funcionarios,w_dt_inicial,w_tipo_faltas,w_qtd_faltas,w_i_motivos_faltas,2,w_comp_descto,null,'N',null,null,
					null,1, w_i_faltas);
		end if;
	end for;
end;
commit;
