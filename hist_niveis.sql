CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');

COMMIT;


begin
  declare cur_conver dynamic scroll cursor for
	select DISTINCT 1,
			(select i_niveis from bethadba.niveis where nome = dsfaixasalarial and i_niveis = cdfaixasalarial) as i_niveis,	
			dtCriacao = if (select datetime(max(t3.dtInicioValidade)) from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO t3 
									where t1.cdEstruturaSalarial = t3.cdEstruturaSalarial and t1.vlFaixaSalarial = t3.vlFaixaSalarial
									and t1.cdFaixaSalarial = t3.cdFaixaSalarial and t1.nrSequenciaFaixa = t3.nrSequenciaFaixa) is null then
										(select datetime(max(t3.dtreferencia)) from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO t3 
										where t1.cdEstruturaSalarial = t3.cdEstruturaSalarial and t1.vlFaixaSalarial = t3.vlFaixaSalarial
										and t1.cdFaixaSalarial = t3.cdFaixaSalarial and t1.nrSequenciaFaixa = t3.nrSequenciaFaixa)
									else
										(select datetime(max(t3.dtInicioValidade)) from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO t3 
										where t1.cdEstruturaSalarial = t3.cdEstruturaSalarial and t1.vlFaixaSalarial = t3.vlFaixaSalarial
										and t1.cdFaixaSalarial = t3.cdFaixaSalarial and t1.nrSequenciaFaixa = t3.nrSequenciaFaixa)
									endif,
			t1.cdMotivoReajuste as i_motivos,
			0 as vlr_anterior,
			t1.vlFaixaSalarial as valor_novo,
			0 as perc_aumento,	
			t1.cdEstruturaSalarial as i_planos_salariais,
			null as vlr_aumento,
			null as i_atos,
			t1.nrHorasReferencia,
			'N' as coeficiente,
			'N' as coeficiente_anterior
	from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO t1  
	where i_niveis is not null
	and not exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
						where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
						and gs.cdNivelSalarial = t1.nrNivelSalarial
						and ((gs.dsNivelSalarial like 'Classe' and gs.cdNivelSalarial = 2) or (gs.dsNivelSalarial like 'Classe' and gs.cdNivelSalarial = 1) or (gs.dsNivelSalarial like 'valor' and gs.cdNivelSalarial = 1) 
								or (gs.dsNivelSalarial like 'cargo' and not exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
																																	where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
																																	and gs.cdNivelSalarial = 3))
								))
	order by 1,2 asc;	

  // *****  Tabela bethadba.niveis
  declare w_i_entidades integer;
  declare w_i_niveis integer;
  declare w_i_motivos integer;
  declare w_perc_aumento integer;
  declare w_valor decimal(12,2);
  declare w_valor_aumento decimal(12,2);
  declare w_valor_anterior decimal(12,2);
  declare w_i_atos decimal(12,2);
  declare w_carga_hor decimal(5,2);
  declare w_coeficiente char(1);
  declare w_coeficiente_anterior char(1);
  declare w_i_planos_salariais smallint;
  declare w_dtCriacao datetime;
  // *****  Tabela tecbth.salariofaixa
  declare w_cdFaixaSalarial varchar(50);
  declare w_nrSequenciaFaixa integer;
  declare w_dsFaixaSalarial varchar(100);
  declare w_vlFaixaSalarial double;
  // *****  Variaveis auxiliares
  declare w_linha long varchar;
  declare w_codi_conv integer;
  declare w_cont integer;
  declare w_cont_aux integer;
  set w_cont=0;
  set w_cont_aux=0;
  open cur_conver with hold;
  L_item: loop
    fetch next cur_conver into w_i_entidades, w_i_niveis, w_dtCriacao, w_i_motivos, w_valor_anterior, w_valor, w_perc_aumento, w_i_planos_salariais, w_valor_aumento, w_i_atos, w_carga_hor, w_coeficiente, w_coeficiente_anterior;
    if sqlstate = '02000' then
      leave L_item
    end if;
    set w_cont=w_cont+1;
    // *****  Converte tabela bethadba.niveis
   -- set tw_i_niveis=tw_i_niveis;--cast (w_cdFaixaSalarial AS INTEGER);--right(w_cdFaixaSalarial,4);

    if w_valor = 0.0 then
      set w_valor= 0.01
    end if;
   if w_valor_anterior = 0.0 then
      set w_valor_anterior= 0.01
    end if;
   	--if w_carga_hor = 0 then set w_carga_hor = 180 end if;
    if w_i_motivos = 0 then set w_i_motivos = 5 end if;
  
    message ' i_niveis.: '||string(w_i_niveis) || ' Data.: ' || w_dtCriacao to client;
    if not exists(select 1 from bethadba.hist_niveis where
        i_entidades = w_i_entidades and
        i_niveis = w_i_niveis and dt_alteracoes = w_dtCriacao) then
 
      insert into bethadba.hist_niveis(i_entidades,i_niveis,dt_alteracoes,i_motivos_altsal,vlr_anterior,vlr_novo,perc_aumento,i_planos_salariais,vlr_aumento,i_atos,carga_hor,coeficiente,coeficiente_anterior) 
      values(w_i_entidades,w_i_niveis,w_dtCriacao,w_i_motivos,w_valor_anterior,w_valor,w_perc_aumento,w_i_planos_salariais,w_valor_aumento,w_i_atos, w_carga_hor,w_coeficiente,w_coeficiente_anterior) 
    end if
  end loop L_item;
  close cur_conver
end;

commit;
 



--insert into bethadba.hist_niveis on existing skip 

--select distinct 1,(select i_niveis from bethadba.niveis where nome = cdfaixasalarial ) as i_niveis,dtiniciovalidade,1,vlfaixasalarial,vlfaixasalarial as novo,100,1,0,null,(select carga_hor from bethadba.niveis where nome = cdfaixasalarial ) as carga, 
--'N','N' from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO where i_niveis is not null 