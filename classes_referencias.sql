
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');

COMMIT;

begin
  declare cur_conver dynamic scroll cursor for
	select 1, t1.cdEstruturaSalarial as plano,
			t1.cdFaixaSalarial as faixa,
			(select first n.i_niveis from bethadba.niveis n where n.i_planos_salariais = t1.cdEstruturaSalarial 
			and  n.nome = t1.dsFaixaSalarial) as i_niveis					
	from tecbth_delivery.gp001_SALARIOFAIXA t1
	where exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
						where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
						and gs.cdNivelSalarial = t1.nrNivelSalarial
						and ((gs.dsNivelSalarial like 'Classe' and gs.cdNivelSalarial = 2) or (gs.dsNivelSalarial like 'Classe' and gs.cdNivelSalarial = 1) 
								or (gs.dsNivelSalarial like 'cargo' and not exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
																																	where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
																																	and gs.cdNivelSalarial = 3))
								) )
	order by 4 asc;

  // *****  Tabela bethadba.niveis
  declare w_i_entidades integer;
  declare w_i_niveis integer;
  declare w_nome char(50);
  declare w_carga_hor decimal(5,2);
  declare w_coeficiente char(1);
  declare w_i_planos_salariais smallint;
  declare w_dtCriacao date;
  declare w_cdFaixaSalarial varchar(50);
  declare w_plano integer;
  declare w_faixa varchar(100);
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
    fetch next cur_conver into w_i_entidades, w_plano,w_faixa,w_i_niveis;
    if sqlstate = '02000' then
      leave L_item
    end if;
    set w_cont=w_cont+1;
	FOR teste AS curs CURSOR FOR
   		select
			t1.cdEstruturaSalarial as planod,
			t1.cdFaixaSalarial as w_faixad,
			t1.sgFaixaSalarial as w_i_clas_niveisdd,	
			left(t1.sgFaixaSalarial,1) as w_i_clas_niveisd,								
			w_i_referenciasd = right(w_faixad,3),
			t1.vlFaixaSalarial as w_valor,
			number(*) as w_ordem	
		from tecbth_delivery.gp001_SALARIOFAIXA t1
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
		and planod = w_plano and left(w_faixad,LENGTH(w_faixa)) = w_faixa
	
 	DO
 	  
	    message 'Nivel.: '||string(w_i_clas_niveisd)||' i_niveis.: '||string(w_ordem) to client;
	    if not exists(select 1 from bethadba.clas_niveis where
	        i_entidades = w_i_entidades and
	        i_niveis = w_i_niveis and
	        i_clas_niveis = w_i_clas_niveisd and
	        i_referencias = w_i_referenciasd) then
	  
	      insert into bethadba.clas_niveis( i_entidades,i_niveis,i_clas_niveis,i_referencias,valor,ordem) 
	      values(w_i_entidades,w_i_niveis, w_i_clas_niveisd,w_i_referenciasd,w_valor,w_ordem) ;
	      
	      insert into tecbth_delivery.antes_depois(tipo, antes_1, antes5, antes6, depois_1, depois_2, depois5, depois6) 
	      values('C', planod, w_i_clas_niveisdd, w_faixad, w_i_niveis, w_ordem, w_i_clas_niveisd, w_i_referenciasd) ;
	    end if
	END FOR;
  end loop L_item;
  close cur_conver
end;