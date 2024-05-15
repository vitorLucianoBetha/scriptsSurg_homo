if  exists (select 1 from sys.sysprocedure where creator = (select user_id from sys.sysuserperms where user_name = current user) and proc_name = 'cnv_cargos') then
	drop procedure cnv_cargos;
end if
;


CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;



begin
	// ***** bethadba.cargos
	declare w_i_cbo char(6);
	declare w_i_tipos_cargos smallint;
	declare w_cdfaixasalarial char(50);
    declare ws_cdfaixasalarial integer;
	declare w_nrsequenciafaixa integer;
	declare w_cdestruturasalarial integer;
	declare w_cdgrupofaixasalarial integer;
	declare w_dt_alteracoes_aux datetime;
	declare w_dedic_exclu char(50);
	
	// ***** bethadba.hist_cargos_compl
	declare w_i_config_ferias_subst smallint;
	--BUG BTHSC-7633
	ooLoop: for oo as cnv_cargos dynamic scroll cursor for
	-- BUG NOME CARGO BTHSC-7894
		select 1 as w_i_entidades,gp001_CARGO.CdCargo as w_i_cargos,cdGrupoCboCargo as w_cdGrupoCboCargo,cdCboCargo as w_cdCboCargo, dedicExcl as w_dedic_exclu,TpCargo as w_TpCargo,w_i_cargos || ' - ' ||  upper(DsCargo) as w_nome,isnull((select  first qt_vagas from tecbth_delivery.gp001_QUADRO_VAGAS WHERE gp001_CARGO.cdcargo = gp001_QUADRO_VAGAS.idf_cargo 
),1) as w_vagas_acresc,
			isnull((select  first qt_vagas from tecbth_delivery.gp001_QUADRO_VAGAS WHERE gp001_CARGO.cdcargo = gp001_QUADRO_VAGAS.idf_cargo 
),1) as w_qtd_vagas,date(DtLeiCargo) as w_dt_lei,date(DtLeiCargo) as w_dt_vigorar,NrLeiCargo as w_num_lei,CdTribunal as w_CdTribunal,DtDesativacao as w_dt_leii,
			DtDesativacao as w_dt_vigorarr,ymd(year(DtLeiCargo),month(DtLeiCargo),1) as w_dt_alteracoes, DtDesativacao as w_DtDesativacao, isnull(In13Sal, 'N')  as decimo,if cdtipoferias=0 then null else cdtipoferias endif as w_i_config_ferias
		from tecbth_delivery.gp001_CARGO left join  tecbth_delivery.gp001_FUNCIONARIO on gp001_cargo.cdCargo = gp001_FUNCIONARIO.cdCargo 

	do
		
		set w_i_cbo = null;
		set w_i_tipos_cargos = null;
		set w_i_config_ferias_subst = null;
		set w_cdfaixasalarial = null;
		set w_nrsequenciafaixa = null;
		set w_cdestruturasalarial = null;
		set w_cdgrupofaixasalarial = null;

		/*
		// *****  Converte tabela bethadba.cargos		
		if w_cdGrupoCboCargo != 0 then
			if length(w_cdGrupoCboCargo) = 4 then
				if length(w_cdCboCargo) = 2 then
					set w_i_cbo=string(w_cdGrupoCboCargo)--+string(w_cdCboCargo)
				else
					set w_i_cbo=string(w_cdGrupoCboCargo)--+'0'+string(w_cdCboCargo)
				end if
			else
				if length(w_cdCboCargo) = 2 then
					set  w_i_cbo=string(w_cdGrupoCboCargo)--+string(w_cdCboCargo)
				else
					set w_i_cbo='0'+string(w_cdGrupoCboCargo)+'0'+string(w_cdCboCargo)
				end if
			end if		
		else
			set w_i_cbo=null
		end if;
		*/
		--BUG BTHSC-7614
		set w_i_cbo=string(w_cdGrupoCboCargo);
		
		if(w_i_cbo = '000000') or(trim(w_i_cbo) = '') then
			set w_i_cbo=null
		end if;

		if w_dedic_exclu in(30001) then 
			set w_dedic_exclu = 'S'
			else 
			set w_dedic_exclu= 'N'
		end if;
		
		if not exists(select 1 from bethadba.cbo where i_cbo = w_i_cbo) then
			set w_i_cbo=null
		end if;
		
		if w_TpCargo in(99,0) then
			set w_i_tipos_cargos=99
		else
			set w_i_tipos_cargos=w_TpCargo
		end if;
		--select * from bethadba.tipos_cargos
		message 'Car.: '||w_i_tipos_cargos||' Nom.: '||w_i_tipos_cargos||' CBO.: '||w_i_tipos_cargos to client;
		
		insert into bethadba.cargos(i_entidades,i_cargos,i_cbo,i_tipos_cargos,nome)on existing skip
		values(w_i_entidades,w_i_cargos,w_i_cbo,w_i_tipos_cargos,w_nome);
		
		// *****  Converte tabela bethadba.cargos_compl 		
		if w_i_tipos_cargos = any(select i_tipos_cargos from bethadba.tipos_cargos where classif = 2) then
			set w_i_config_ferias_subst=null
		else
			set w_i_config_ferias_subst=1
		end if;
			
		insert into bethadba.cargos_compl(i_entidades,i_cargos,i_config_ferias,i_config_ferias_subst,qtd_vagas,rol,grau_instrucao,codigo_tce,decimo_terc,requisitos,atividades)on existing skip
		values (w_i_entidades,w_i_cargos,w_i_config_ferias,w_i_config_ferias_subst,w_qtd_vagas,null,1,w_i_cargos,decimo,null,null);
		
		
		// *****  Converte tabela bethadba.hist_cargos_compl
		select first nrsequenciafaixa,cdestruturasalarial,cdgrupofaixasalarial
		into w_nrsequenciafaixa,w_cdestruturasalarial,w_cdgrupofaixasalarial
		from tecbth_delivery.gp001_cargosalariofaixa
		where cdcargo = w_i_cargos;
			
		select cdfaixasalarial 
		into w_cdfaixasalarial
	  from gp001_salariofaixa as salariofaixa
		where nrsequenciafaixa    = w_nrsequenciafaixa
		  and cdestruturasalarial = w_cdestruturasalarial
		  and cdgrupofaixasalarial = w_cdgrupofaixasalarial
		  and nrnivelsalarial in(2,3);
		
		if w_dt_alteracoes is not null then
			if w_dt_alteracoes = w_dt_alteracoes_aux then
				set w_dt_alteracoes = dateadd(hour,1,w_dt_alteracoes);
			end if;
		end if;
		select i_niveis into ws_cdfaixasalarial from bethadba.niveis where i_entidades = w_i_entidades and nome = w_cdfaixasalarial;

		if exists(select 1 from bethadba.niveis where i_entidades = w_i_entidades and nome = w_cdfaixasalarial) then
			insert into bethadba.hist_cargos_compl(i_entidades,i_cargos,dt_alteracoes,i_niveis,i_clas_niveis_ini,i_referencias_ini,i_clas_niveis_fin,i_referencias_fin) 
			values (w_i_entidades,w_i_cargos,isnull(w_dt_alteracoes,'1990-01-01'),ws_cdfaixasalarial,null,null,null,null);
		end if;
		
		// *****  Converte tabela bethadba.mov_cargos
		if w_dt_alteracoes is null then
			set w_dt_alteracoes='2005-01-01'
		end if;
		
		insert into bethadba.mov_cargos(i_entidades,i_cargos,dt_alteracoes,tipo_atualiz,num_lei,dt_lei,dt_vigorar,vagas_acresc,vagas_reduzir)on existing skip
		values (w_i_entidades,w_i_cargos,w_dt_alteracoes,1,w_num_lei,w_dt_lei,w_dt_vigorar,w_vagas_acresc,null);
		
		if w_DtDesativacao is not null then
			set w_dt_alteracoes=ymd(year(w_DtDesativacao),month(w_DtDesativacao),1);
		
			insert into bethadba.mov_cargos(i_entidades,i_cargos,dt_alteracoes,tipo_atualiz,num_lei,dt_lei,dt_vigorar,vagas_acresc,vagas_reduzir)on existing update
			values (w_i_entidades,w_i_cargos,w_dt_alteracoes,3,null,w_dt_leii,w_dt_vigorarr,w_vagas_acresc,null) 
		end if;
		
		insert into bethadba.hist_cargos_cadastro(i_entidades,i_cargos,i_competencias, codigo_esocial, nome, i_tipos_cargos, aposent_especial, acumula_cargos, dedicacao_exclusiva)on existing skip
		values (w_i_entidades,w_i_cargos, '1950-01-01', w_i_cargos, w_nome, w_i_tipos_cargos, 0, 'N', w_dedic_exclu);
		
		
		set w_dt_alteracoes_aux = w_dt_alteracoes;
		
	end for;
end
;