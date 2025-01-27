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

