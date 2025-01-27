
begin
	// *****  Tabela bethadba.rescisoes
	declare w_i_funcionarios integer;
	declare w_i_motivos_resc smallint;
	declare w_i_motivos_apos smallint;
	declare w_dt_aviso date; 

	ooLoop: for oo as cnv_rescisoes dynamic scroll cursor for
		select 1 as w_i_entidades,CdMatricula as w_cdMatricula,SqContrato as w_SqContrato,CdDesligamento as w_CdDesligamento,date(DtRescisao) as w_dt_rescisao, DtAvisoPrevio as w_DtAvisoPrevio
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

			
			message 'Afa. Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Dt.: '||w_dt_rescisao to client;
			
			insert into bethadba.afastamentos(i_entidades,i_funcionarios,dt_afastamento,i_tipos_afast,i_atos)on existing skip
			values (w_i_entidades,w_i_funcionarios,w_dt_rescisao,7,null);
		
	end for;
end;
COMMIT;



CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;

/*


begin
	// *****  Tabela bethadba.rescisoes
	declare w_i_funcionarios integer;
	declare w_i_motivos_resc smallint;
	declare w_i_motivos_apos smallint;
	declare w_dt_aviso date; 

	ooLoop: for oo as cnv_rescisoes dynamic scroll cursor for
		select 1 as w_i_entidades,CdMatricula as w_cdMatricula,SqContrato as w_SqContrato,CdDesligamento as w_CdDesligamento,date(DtAposentadoria) as w_dt_rescisao, date(DtAposentadoria)  as w_DtAvisoPrevio
		from tecbth_delivery.gp001_funcionario 
		where DtAposentadoria is not null  
		order by 1,2,3 asc	
		
	do
		
		// *****  Inicializa Variaveis
		set w_i_funcionarios=null;
		set w_i_motivos_resc=null;
		set w_i_motivos_apos=null;
		set w_dt_aviso=null;
		
		// *****  Converte tabela bethadba.rescisao
		set w_i_funcionarios=cast(w_cdMatricula as integer);

			
			message 'Afa. Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Dt.: '||w_dt_rescisao to client;
			
			insert into bethadba.afastamentos(i_entidades,i_funcionarios,dt_afastamento,i_tipos_afast,i_atos)on existing skip
			values (w_i_entidades,w_i_funcionarios,w_dt_rescisao,19,null);
		
	end for;
end;
COMMIT;





CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;
