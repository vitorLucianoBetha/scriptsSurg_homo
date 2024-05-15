
begin
  declare cur_conver dynamic scroll cursor for select 1,t1.cdFaixaSalarial,
      t1.cdFaixaSalarial,t1.vlFaixaSalarial,number(*) AS CODIGO from
      gp001_salariofaixa  as t1,  gp001_salariofaixa as t2 where
     -t1.NrNivelSalarial in(2,3) and  
      substr(t1.CdFaixaSalarial,1,5)  = t2.cdFaixaSalarial 
     order by 1 asc,2 asc;


  // *****  Tabela bethadba.niveis
  declare w_i_entidades integer;
  declare w_i_niveis integer;
  declare tw_i_niveis integer;
  declare w_nome char(50);
  declare w_valor decimal(12,2);
  declare w_carga_hor decimal(5,2);
  declare w_coeficiente char(1);
  declare w_i_planos_salariais smallint;
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
    fetch next cur_conver into w_i_entidades,w_cdFaixaSalarial,w_DsFaixaSalarial,
      w_vlFaixaSalarial,tw_i_niveis;
    if sqlstate = '02000' then
      leave L_item
    end if;
    set w_cont=w_cont+1;
    // *****  Inicializa Variaveis
    set w_i_niveis=null;
    set w_nome=null;
    set w_valor=null;
    set w_carga_hor=null;
    set w_coeficiente=null;
    set w_i_planos_salariais=null;
    // *****  Converte tabela bethadba.niveis
   -- set tw_i_niveis=tw_i_niveis;--cast (w_cdFaixaSalarial AS INTEGER);--right(w_cdFaixaSalarial,4);
    set w_i_niveis= tw_i_niveis;
 /*
(CASE
                        WHEN tw_i_niveis ='01A' THEN 10099
                        WHEN tw_i_niveis ='01B' THEN 10098
                        WHEN tw_i_niveis ='EF1' THEN 10097
                        WHEN tw_i_niveis ='EF2' THEN 10096
                        WHEN tw_i_niveis ='EF3' THEN 10096
                        WHEN tw_i_niveis ='EF4' THEN 10095
                        WHEN tw_i_niveis ='EF5' THEN 10094
                        WHEN tw_i_niveis ='EF6' THEN 10093
                        WHEN tw_i_niveis ='EF7' THEN 10092
                        WHEN tw_i_niveis ='EF8' THEN 10091
                        WHEN tw_i_niveis ='EF9' THEN 10090
                        WHEN tw_i_niveis ='0XX' THEN 10089
                        ELSE tw_i_niveis
                        END);
                   
*/

    set w_nome=w_DsFaixaSalarial;
    set w_valor=cast(w_vlFaixaSalarial as decimal(12,2));
    if w_valor = 0.0 then
      set w_valor=.01
    end if;
    set w_carga_hor=220.0;
    set w_coeficiente='N';
    set w_i_planos_salariais=1;
  
    message 'Nivel.: '||string(w_nome)||' i_niveis.: '||string(w_i_niveis) to client;
    if not exists(select 1 from bethadba.niveis where
        i_entidades = w_i_entidades and
        i_niveis = w_i_niveis) then
 
      insert into bethadba.niveis( i_entidades,i_niveis,nome,valor,carga_hor,coeficiente,
        i_planos_salariais) values( w_i_entidades,w_i_niveis,w_nome,w_valor,w_carga_hor,w_coeficiente,
        w_i_planos_salariais) 
    end if
  end loop L_item;
  close cur_conver
end;

rollback;
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit','on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;
commit;
-- HIST Niveis BUG BTHSC-8182 Não migrou os históricos dos níveis salariais
ROLLBACK;
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit','on');
call bethadba.pg_setoption('fire_triggers','off');
COMMIT;


insert into bethadba.hist_niveis on existing skip 

select distinct 1,(select i_niveis from bethadba.niveis where nome = cdfaixasalarial ) as i_niveis,dtiniciovalidade,1,vlfaixasalarial,vlfaixasalarial as novo,100,1,0,null,(select carga_hor from bethadba.niveis where nome = cdfaixasalarial ) as carga, 
'N','N' from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO where i_niveis is not null 