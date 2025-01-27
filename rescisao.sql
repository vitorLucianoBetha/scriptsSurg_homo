
begin
	// *****  Tabela bethadba.rescisoes
	declare w_i_funcionarios integer;
	declare w_i_motivos_resc smallint;
	declare w_i_motivos_apos smallint;
	declare w_dt_aviso date; 

	ooLoop: for oo as cnv_rescisoes dynamic scroll cursor for
		select 1 as w_i_entidades,CdMatricula as w_cdMatricula,SqContrato as w_SqContrato,CdDesligamento as w_CdDesligamento,date(dtAposentadoria) as w_dt_rescisao,DtAvisoPrevio as w_DtAvisoPrevio
		from tecbth_delivery.gp001_funcionario 
		where dtRescisao is not null  
		order by 1,2,3 asc	
	do
		
		// *****  Inicializa Variaveis
		set w_i_funcionarios=null;
		set w_i_motivos_resc=null;
		set w_i_motivos_apos=null;
		set w_dt_aviso=null;
		
		// *****  Converte tabela bethadba.rescisao
		set w_i_funcionarios=cast(w_cdMatricula as integer);
		
		if exists (select 1 from bethadba.funcionarios where i_entidades = w_i_entidades and i_funcionarios = w_i_funcionarios) then	
           select DISTINCT i_motivos_resc,i_motivos_apos into w_i_motivos_resc,w_i_motivos_apos  from  tecbth_delivery.gp001_tipodesligamento where cddesligamento = w_CdDesligamento;
           if w_DtAvisoPrevio is null then
				set w_dt_aviso=w_dt_rescisao
			else
				set w_dt_aviso=w_DtAvisoPrevio
			end if;
			
			message 'Res. Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Dt.: '||w_dt_rescisao to client;
	
			insert into bethadba.rescisoes(i_entidades,i_funcionarios,i_rescisoes,i_motivos_resc,i_motivos_apos,i_atos,dt_aviso,dt_rescisao,aviso_ind,vlr_saldo_fgts,fgts_mesant,compl_mensal,
										ferias_venc,ferias_prop,complementar,aviso_desc)on existing skip
			values (w_i_entidades,w_i_funcionarios,1,isnull(w_i_motivos_resc,1),w_i_motivos_apos,null,w_dt_aviso,w_dt_rescisao,'N',0.0,'N','N',0,0,'N','N');
					
			update bethadba.locais_mov 
			set dt_final = w_dt_rescisao 
			where i_entidades = w_i_entidades 
			and i_funcionarios = w_i_funcionarios 
			and dt_final is null;
			
			update bethadba.hist_cargos 
			set dt_saida = w_dt_rescisao 
			where i_entidades = w_i_entidades 
			and i_funcionarios = w_i_funcionarios 
			and dt_saida is null;
		end if;
		
	end for;
end;
COMMIT


/* 

CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;

begin
	// *****  Tabela bethadba.rescisoes
	declare w_i_funcionarios integer;
	declare w_dt_aviso date; 
    declare w_i_motivos_apos integer;

	ooLoop: for oo as cnv_rescisoes dynamic scroll cursor for
		select 1 as w_i_entidades,CdMatricula as w_cdMatricula,SqContrato as w_SqContrato, if CdDesligamento  = 0 then 1 else CdDesligamento endif as w_i_motivos_resc,date(dtAposentadoria) as w_dt_rescisao,date(dtAposentadoria) as w_DtAvisoPrevio
		from tecbth_delivery.gp001_funcionario 
		where dtAposentadoria is not null  
		order by 1,2,3 asc	
	do
		
		// *****  Inicializa Variaveis
		set w_i_funcionarios=null;
		set w_dt_aviso=null;
		set w_i_motivos_apos = 16;
		
		// *****  Converte tabela bethadba.rescisao
		set w_i_funcionarios=cast(w_cdMatricula as integer);
		

          
			
			message 'Res. Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Dt.: '||w_dt_rescisao to client;
	
			insert into bethadba.rescisoes(i_entidades,i_funcionarios,i_rescisoes,i_motivos_resc,i_motivos_apos,i_atos,dt_aviso,dt_rescisao,aviso_ind,vlr_saldo_fgts,fgts_mesant,compl_mensal,
										ferias_venc,ferias_prop,complementar,aviso_desc)on existing skip
			values (w_i_entidades,w_i_funcionarios,1,isnull(w_i_motivos_resc,1),w_i_motivos_apos,null,w_dt_aviso,w_dt_rescisao,'N',0.0,'N','N',0,0,'N','N');
					
			update bethadba.locais_mov 
			set dt_final = w_dt_rescisao 
			where i_entidades = w_i_entidades 
			and i_funcionarios = w_i_funcionarios 
			and dt_final is null;
			
			update bethadba.hist_cargos 
			set dt_saida = w_dt_rescisao 
			where i_entidades = w_i_entidades 
			and i_funcionarios = w_i_funcionarios 
			and dt_saida is null;
		
	end for;
end;
COMMIT;