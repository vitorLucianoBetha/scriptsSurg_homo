
begin
  declare cur_conver dynamic scroll cursor for
  	select 1,
  	  t1.dsFaixaSalarial,
	    t1.cdEstruturaSalarial,
      t1.cdFaixaSalarial,
      t1.vlFaixaSalarial,
      t1.nrHorasReferencia,
      date(t1.dtInicioValidade),
      number(*) AS CODIGO      
    from tecbth_delivery.gp001_salariofaixa  as t1
    where exists (select 1 from tecbth_delivery.gp001_SALARIOESTRUTURANIVEL gs
						where gs.cdEstruturaSalarial = t1.cdEstruturaSalarial
						and gs.cdNivelSalarial = t1.nrNivelSalarial
						and ((gs.dsNivelSalarial like 'Classe' and gs.cdNivelSalarial = 2) or (gs.dsNivelSalarial like 'Classe' and gs.cdNivelSalarial = 1) or (gs.dsNivelSalarial like 'valor' and gs.cdNivelSalarial = 1) ) )
    order by 1 asc,2 asc, 3 asc;

  // *****  Tabela bethadba.niveis
  declare w_i_entidades integer;
  declare w_i_niveis integer;
  declare tw_i_niveis integer;
  declare w_nome char(50);
  declare w_valor decimal(12,2);
  declare w_carga_hor decimal(5,2);
  declare w_coeficiente char(1);
  declare w_i_planos_salariais smallint;
 declare w_dtCriacao date;
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
    fetch next cur_conver into w_i_entidades,w_DsFaixaSalarial,w_i_planos_salariais,w_cdFaixaSalarial,w_vlFaixaSalarial,w_carga_hor,w_dtCriacao,tw_i_niveis;
    if sqlstate = '02000' then
      leave L_item
    end if;
    set w_cont=w_cont+1;
    // *****  Inicializa Variaveis
    set w_i_niveis=null;
    set w_nome=null;
    set w_valor=null;
    set w_coeficiente=null;
    // *****  Converte tabela bethadba.niveis
   -- set tw_i_niveis=tw_i_niveis;--cast (w_cdFaixaSalarial AS INTEGER);--right(w_cdFaixaSalarial,4);
    set w_i_niveis= tw_i_niveis;

    set w_nome=w_DsFaixaSalarial;
    set w_valor=cast(w_vlFaixaSalarial as decimal(12,2));
    if w_valor = 0.0 then
      set w_valor=.01
    end if;
    set w_coeficiente='N';
   	if w_carga_hor = 0 then set w_carga_hor = 180 end if;
  
    message 'Nivel.: '||string(w_nome)||' i_niveis.: '||string(w_i_niveis) to client;
    if not exists(select 1 from bethadba.niveis where
        i_entidades = w_i_entidades and
        i_niveis = w_i_niveis) then
 
      insert into bethadba.niveis( i_entidades,i_niveis,nome,valor,carga_hor,coeficiente,i_planos_salariais,dt_criacao) 
      values( w_i_entidades,w_i_niveis,w_nome,w_valor,w_carga_hor,w_coeficiente,w_i_planos_salariais,w_dtCriacao) 
    end if
  end loop L_item;
  close cur_conver
end;


--insert into bethadba.hist_niveis on existing skip 

--select distinct 1,(select i_niveis from bethadba.niveis where nome = cdfaixasalarial ) as i_niveis,dtiniciovalidade,1,vlfaixasalarial,vlfaixasalarial as novo,100,1,0,null,(select carga_hor from bethadba.niveis where nome = cdfaixasalarial ) as carga, 
--'N','N' from tecbth_delivery.gp001_SALARIOFAIXA_HISTORICO where i_niveis is not null 