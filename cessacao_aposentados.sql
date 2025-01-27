
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;

begin
	// *****  Tabela bethadba.rescisoes
	declare w_i_funcionarios integer;
	declare w_dt_aviso date; 
    declare w_i_motivos_apos integer;
   declare w_i_motivos_resc integer;
    

	ooLoop: for oo as cnv_rescisoes dynamic scroll cursor for
		select 1 as w_i_entidades,CdMatricula as w_cdMatricula,SqContrato as w_SqContrato, 8 as CdDesligamento ,date(dtRescisao) as w_dt_rescisao,date(dtRescisao) as w_DtAvisoPrevio
		from tecbth_delivery.gp001_funcionario 
		where dtRescisao is not null and CdDesligamento = 8 and CdCargo = 1
		order by 1,2,3 asc	
	do
		
		// *****  Inicializa Variaveis
		set w_i_funcionarios=null;
		set w_dt_aviso=null;
		set w_i_motivos_apos = null;
        set w_i_motivos_resc = 8;
		
		// *****  Converte tabela bethadba.rescisao
		set w_i_funcionarios=cast(w_cdMatricula as integer);
		

          
			
			message 'Res. Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Dt.: '||w_dt_rescisao to client;
	
			insert into bethadba.rescisoes(i_entidades,i_funcionarios,i_rescisoes,i_motivos_resc,i_motivos_apos,i_atos,dt_aviso,dt_rescisao,aviso_ind,vlr_saldo_fgts,fgts_mesant,compl_mensal,
										ferias_venc,ferias_prop,complementar,aviso_desc)on existing skip
			values (w_i_entidades,w_i_funcionarios,1,w_i_motivos_resc,w_i_motivos_apos,null,w_dt_aviso,w_dt_rescisao,'N',0.0,'N','N',0,0,'N','N');
					
		
	end for;
end;
COMMIT;
