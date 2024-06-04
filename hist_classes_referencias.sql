
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');

COMMIT;

begin
  declare cur_conver dynamic scroll cursor for
	select DISTINCT 1 as w_entidade,
   		(select first ad.depois_1 from tecbth_delivery.antes_depois ad
   		where ad.antes5 = t1.sgFaixaSalarial and ad.antes6 = t1.cdFaixaSalarial and ad.antes_1 = t1.cdEstruturaSalarial) as w_i_niveis,
		if isnumeric(left(t1.sgFaixaSalarial,1)) <> 1 then upper(left(t1.sgFaixaSalarial,1)) else upper(left(t1.dsFaixaSalarial,1)) endif as w_i_clas_niveis,								
		w_i_referencias = right(t1.cdFaixaSalarial,3),
		w_dt_alteracoes = (select max(t2.dtreferencia) from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO t2
											where t2.cdEstruturaSalarial = t1.cdEstruturaSalarial and t2.nrNivelSalarial = t1.nrNivelSalarial
											and t2.vlFaixaSalarial = t1.vlFaixaSalarial),
		t1.vlFaixaSalarial as w_valor,
		(select first ad.depois_2 from tecbth_delivery.antes_depois ad
   		where ad.antes5 = t1.sgFaixaSalarial and ad.antes6 = t1.cdFaixaSalarial and ad.antes_1 = t1.cdEstruturaSalarial) as w_ordem,
   		t1.cdEstruturaSalarial as w_plano
	from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO t1
	where exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
				where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
				and gs.cdNivelSalarial = t1.nrNivelSalarial
				and (gs.dsNivelSalarial like 'Nivel' or gs.dsNivelSalarial like 'Faixa'))
	and exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
				where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
				and gs.cdNivelSalarial = t1.nrNivelSalarial - 1
				and (gs.dsNivelSalarial like 'Classe')
						or (gs.dsNivelSalarial like 'cargo' and not exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
																																	where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
																																	and gs.cdNivelSalarial = 3))
				)
	and w_i_niveis is not null
	order by 1,2,3,4,5 asc;

  // *****  Tabela bethadba.niveis
  declare w_i_entidades integer;
  declare w_i_niveis integer;
  declare w_i_niveis_anterior integer;
  declare w_i_motivos_altsal integer; 
  declare w_plano integer;
  declare w_valor decimal(20,2);
  declare w_valor_anterior decimal(20,2);
  declare w_vlr_anterior decimal(20,2);
  declare w_vlr_anterior_nivel decimal(20,2);
  declare w_valor_nivel decimal(20,2); 
  declare w_perc_aumento decimal(20,2);  
  declare w_vlr_aumento decimal(20,2);
  declare w_carga_hor decimal(20,2);
  declare w_coeficiente char(1);
  declare w_coeficiente_anterior char(1);
  declare w_i_planos_salariais smallint;
  declare w_dt_alteracoes datetime;
  declare w_dt_alteracoes_anterior datetime;
  declare w_i_clas_niveis varchar(50);
  declare w_i_clas_niveis_anterior varchar(50);
  declare w_ordem integer;
  declare w_i_atos integer; 
  declare w_i_referencias varchar(100);
  declare w_i_referencias_anterior varchar(100);
  // *****  Variaveis auxiliares
  declare w_linha long varchar;
  declare w_codi_conv integer;
  declare w_cont integer;
  declare w_cont_aux integer;
  set w_cont = 0;
  set w_cont_aux=0;
  open cur_conver with hold;
  L_item: loop
    fetch next cur_conver into w_i_entidades, w_i_niveis, w_i_clas_niveis, w_i_referencias, w_dt_alteracoes, w_valor, w_ordem, w_plano;
    if sqlstate = '02000' then
      leave L_item
    end if;
   	  
   		if w_cont = 0 then
   			set w_vlr_anterior = 0.01
   		else
   			if w_i_niveis_anterior = w_i_niveis and w_i_clas_niveis_anterior = w_i_clas_niveis and w_i_referencias_anterior = w_i_referencias and w_dt_alteracoes_anterior <> w_dt_alteracoes then
   				set w_vlr_anterior = w_valor_anterior
   			else
   				set w_vlr_anterior = 0.01
   			end if
   		end if;
   	
   		set w_cont = w_cont+1;
	   	set w_i_niveis_anterior = w_i_niveis;
	   	set w_i_clas_niveis_anterior = w_i_clas_niveis;
	   	set w_i_referencias_anterior = w_i_referencias;
	   	set w_dt_alteracoes_anterior = w_dt_alteracoes;
	   	set w_valor_anterior = w_valor;
   		
	   message 'Count: ' || string(w_cont) || ' Nivel.: '||string(w_i_clas_niveis) || ' ' || string(w_i_niveis) ||' Ref.: '||string(w_i_referencias) || ' Dt: ' || string(w_dt_alteracoes) to client;
	   
		if not exists (select 1 from bethadba.hist_niveis hn where
			   hn.i_entidades = w_i_entidades and
			   hn.i_niveis = w_i_niveis and
			   hn.i_planos_salariais = w_plano and
			   hn.dt_alteracoes = w_dt_alteracoes) then
			   
			   set w_i_motivos_altsal = (select first hn.i_motivos_altsal from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_vlr_anterior_nivel = (select first hn.vlr_anterior from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_valor_nivel = (select first hn.vlr_novo from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_perc_aumento = (select first hn.perc_aumento from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_vlr_aumento = (select first hn.vlr_aumento from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_i_atos = (select first hn.i_atos from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_carga_hor = (select first hn.carga_hor from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_coeficiente = (select first hn.coeficiente from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   set w_coeficiente_anterior = (select first hn.coeficiente_anterior from bethadba.hist_niveis hn where hn.i_entidades = w_i_entidades and hn.i_niveis = w_i_niveis and hn.i_planos_salariais = w_plano order by hn.dt_alteracoes desc);
			   
			   insert into bethadba.hist_niveis( i_entidades, i_niveis, dt_alteracoes, i_motivos_altsal, vlr_anterior, vlr_novo, perc_aumento, i_planos_salariais, vlr_aumento, i_atos, carga_hor, coeficiente, coeficiente_anterior) 
	      	   values(w_i_entidades,w_i_niveis,w_dt_alteracoes,w_i_motivos_altsal,w_vlr_anterior_nivel,w_valor_nivel,w_perc_aumento, w_plano, w_vlr_aumento, w_i_atos, w_carga_hor, w_coeficiente,w_coeficiente_anterior) 
		end if;	
		   
	    if not exists(select 1 from bethadba.hist_clas_niveis hcn where
	        hcn.i_entidades = w_i_entidades and
	        hcn.i_niveis = w_i_niveis and
	        hcn.i_clas_niveis = w_i_clas_niveis and
	        hcn.i_referencias = w_i_referencias and
	        hcn.dt_alteracoes = w_dt_alteracoes) then
	  
	      insert into bethadba.hist_clas_niveis( i_entidades,i_niveis,i_clas_niveis,i_referencias,dt_alteracoes,vlr_anterior,vlr_novo,ordem,ordem_anterior) 
	      values(w_i_entidades,w_i_niveis,w_i_clas_niveis,w_i_referencias,w_dt_alteracoes,w_vlr_anterior,w_valor,w_ordem,w_ordem) 
	    end if;
  end loop L_item;
  close cur_conver
end;

rollback;
