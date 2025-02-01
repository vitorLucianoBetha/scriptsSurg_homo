begin
  declare cur_conver dynamic scroll cursor for 
    select 1, Funcionario.CdMatricula as w_cdMatricula ,Funcionario.SqContrato,dtAdmissao,
       Nrdias,NrHorasDia,if DtHistorico is null then dtAdmissao else dtgeracao endif as w_DtHistorico ,HistoricoSalarial.cdEstruturaSalarial,HistoricoSalarial.CdGrupoFaixaSalarial,
       HistoricoSalarial.NrSequenciaFaixa,cdMotivo,VlSalarioFaixa,VlSalario,dtgravacao,1 
 from  tecbth_delivery.gp001_Funcionario as Funcionario,tecbth_delivery.gp001_HistoricoSalarial as HistoricoSalarial,tecbth_delivery.gp001_Escala as Escala 
where  Funcionario.CdMatricula *= HistoricoSalarial.CdMatricula 
  and  Funcionario.SqContrato *= HistoricoSalarial.SqContrato 
  and  Funcionario.CdEscalaTrabalho = Escala.CdEscala 
   

union

select 1,Funcionario.CdMatricula as w_cdMatricula,Funcionario.SqContrato,dtAdmissao,
	   Nrdias,NrHorasDia,if DtHistorico is null then dtAdmissao else dtgeracao endif as w_DtHistorico,HistoricoSalarial.cdEstruturaSalarial,HistoricoSalarial.CdGrupoFaixaSalarial,
	   HistoricoSalarial.NrSequenciaFaixa,cdMotivo,VlSalarioFaixa,VlSalario,dtgravacao,1 
 from  tecbth_delivery.gp001_Funcionario as Funcionario,tecbth_delivery.gp001_HistoricoSalarial as HistoricoSalarial,tecbth_delivery.gp001_Escala as Escala 
where  Funcionario.CdMatricula *= HistoricoSalarial.CdMatricula 
  and  Funcionario.SqContrato *= HistoricoSalarial.SqContrato 
  and  Funcionario.CdEscalaTrabalho = Escala.CdEscala 
   

union

select 1,Funcionario.CdMatricula as w_cdMatricula,Funcionario.SqContrato,dtAdmissao,
       Nrdias,NrHorasDia,if DtHistorico is null then dtAdmissao else dtgeracao endif as w_DtHistorico,HistoricoSalarial.cdEstruturaSalarial,HistoricoSalarial.CdGrupoFaixaSalarial,
       HistoricoSalarial.NrSequenciaFaixa,cdMotivo,VlSalarioFaixa,VlSalario,dtgravacao,1 
 from  tecbth_delivery.gp001_Funcionario as Funcionario,tecbth_delivery.gp001_HistoricoSalarial as HistoricoSalarial,tecbth_delivery.gp001_Escala as Escala 
where  Funcionario.CdMatricula *= HistoricoSalarial.CdMatricula 
  and  Funcionario.SqContrato *= HistoricoSalarial.SqContrato 
  and  Funcionario.CdEscalaTrabalho = Escala.CdEscala 
  
union

select 1,Funcionario.CdMatricula,Funcionario.SqContrato,dtAdmissao,
       Nrdias,NrHorasDia,if DtHistorico is null then dtAdmissao else dtgeracao endif as w_DtHistorico,HistoricoSalarial.cdEstruturaSalarial,HistoricoSalarial.CdGrupoFaixaSalarial,
       HistoricoSalarial.NrSequenciaFaixa,cdMotivo,VlSalarioFaixa,VlSalario,dtgravacao,1 
 from  tecbth_delivery.gp001_Funcionario as Funcionario,tecbth_delivery.gp001_HistoricoSalarial as HistoricoSalarial,tecbth_delivery.gp001_Escala as Escala 
where  Funcionario.CdMatricula *= HistoricoSalarial.CdMatricula 
  and  Funcionario.SqContrato *= HistoricoSalarial.SqContrato 
  and  Funcionario.CdEscalaTrabalho = Escala.CdEscala 
   
order by 1 asc,2 asc,3 asc,7 asc,13 asc;
  // *****  Tabela bethadba.hist_salariais
  declare w_i_entidades integer;
  declare w_i_funcionarios integer;
  declare w_dt_alteracoes timestamp;
  declare w_i_niveis integer;
  declare ws_i_niveis char(50);
  declare w_i_clas_niveis char(3);
  declare w_i_referencias char(3);
  declare w_i_motivos_altsal smallint;
  declare w_i_atos integer;
  declare w_salario decimal(12,2);
  declare w_horas_mes decimal(5,2);
  declare w_horas_sem decimal(5,2);
  // *****  Tabela tecbth_delivery.funcionario
  declare w_CdMatricula integer;
  declare w_SqContrato smallint;
  declare w_DtAdmissao timestamp;
  declare w_cdEstruturaSalarial integer;
  declare w_nrSequenciaFaixa smallint;
  declare w_cdGrupoFaixaSalarial smallint;
  // *****  Tabela tecbth_delivery.historicosalarial
  declare w_DtHistorico timestamp;
  declare w_VlSalarioFaixa double;
  declare w_VlSalario double;
  declare w_cdMotivo smallint;
  declare w_DtGravacao timestamp;
  // *****  Tabela tecbth_delivery.escala
  declare w_Nrdias smallint;
  declare w_NrHorasDia double;
  // *****  Variaveis auxiliares
  declare w_cont integer;
  declare w_number integer;
  declare w_i_funcionarios_aux integer;
  declare w_config smallint;
  declare w_hora_alt integer;
  set w_cont=0;
  set w_i_funcionarios_aux=null;
  set w_number=0;
  open cur_conver with hold;
  L_item: loop
    fetch next cur_conver into w_i_entidades,w_cdMatricula,w_SqContrato,w_dtAdmissao,w_Nrdias,w_NrHorasDia,
      w_DtHistorico,w_cdEstruturaSalarial,w_cdGrupoFaixaSalarial,w_NrSequenciaFaixa,w_cdMotivo,w_VlSalarioFaixa,w_VlSalario,w_dtGravacao,
      w_config;
    if sqlstate = '02000' then
      leave L_item
    end if;
    set w_cont=w_cont+1;
    // *****  Inicializa Variaveis
    set w_i_funcionarios=null;
    set w_dt_alteracoes=null;
    set w_i_niveis=null;
    set w_i_clas_niveis=null;
    set w_i_referencias=null;
    set w_i_motivos_altsal=null;
    set w_i_atos=null;
    set w_salario=null;
    set w_horas_mes=null;
    set w_horas_sem=null;
    // *****  Converte tabela bethadba.hist_salariais
    set w_i_funcionarios=cast(w_cdMatricula as integer);
    set w_dt_alteracoes= w_DtHistorico;
    if w_i_funcionarios_aux <> w_i_funcionarios then
      set w_number=0
    end if;
    set w_number=w_number+1;


 

    if not exists(select 1 from bethadba.niveis where i_entidades = w_i_entidades and i_niveis = w_i_niveis) then
      set w_i_niveis=null
    end if;
    
    if w_VlSalarioFaixa = 0 then
    set w_salario=cast(isnull(w_VlSalario,0) as decimal(12,2))
    else
    set w_salario=cast(isnull(w_VlSalarioFaixa,0) as decimal(12,2))
end if;
    if(w_i_niveis = 0) or(w_i_niveis is null) then
      set w_i_niveis=null;
      set w_i_clas_niveis=null;
      set w_i_referencias=null;
    end if;
    set w_i_motivos_altsal=w_cdMotivo;
    if w_i_motivos_altsal = 0 then
      set w_i_motivos_altsal=1
    end if;
    set w_horas_mes="truncate"(cast((w_nrdias)*w_NrHorasDia*5 as decimal(5,2)),2);
    if w_horas_mes = 200.10 then
		set w_horas_mes = 200.00
	elseif w_horas_mes = 219.90 then
		set w_horas_mes = 220.00
	elseif w_horas_mes = 80.10 then
		set w_horas_mes = 80
	end if;	
    set w_horas_sem=w_horas_mes/5;
    set w_i_atos=null;
    if w_number = 1 then
      set w_i_motivos_altsal=null
    end if;
    print string(w_i_entidades)+' - '+string(w_i_funcionarios)+' - '+string(w_number)+' - Salario - '+string(w_i_niveis)+' - '+string(w_config);
    if not exists(select 1 from bethadba.hist_salariais where
        i_entidades = w_i_entidades and
        i_funcionarios = w_i_funcionarios) then
      insert into bethadba.hist_salariais( i_entidades,i_funcionarios,dt_alteracoes,i_niveis,i_clas_niveis,
        i_referencias,i_motivos_altsal,i_atos,salario,horas_mes,horas_sem) values( w_i_entidades,w_i_funcionarios,
        w_dt_alteracoes,w_i_niveis,w_i_clas_niveis,w_i_referencias,w_i_motivos_altsal,w_i_atos,w_salario,w_horas_mes,
        w_horas_sem) 
    else
      if w_config = 1 then
        if exists(select 1 from bethadba.hist_salariais where
            i_entidades = w_i_entidades and
            i_funcionarios = w_i_funcionarios and
            dt_alteracoes = (select max(dt_alteracoes) from bethadba.hist_salariais where
              i_entidades = w_i_entidades and
              i_funcionarios = w_i_funcionarios) and
            (i_niveis <> w_i_niveis or
            i_motivos_altsal <> w_i_motivos_altsal or
            salario <> w_salario)) then
          if exists(select 1 from bethadba.hist_salariais where
              i_entidades = w_i_entidades and
              i_funcionarios = w_i_funcionarios and
              dt_alteracoes = w_dt_alteracoes) then
            update bethadba.hist_salariais set i_niveis = w_i_niveis,i_clas_niveis = w_i_clas_niveis,
              i_referencias = w_i_referencias,i_motivos_altsal = w_i_motivos_altsal,i_atos = w_i_atos,salario = w_salario,
              horas_mes = w_horas_mes,horas_sem = w_horas_sem where
              i_entidades = w_i_entidades and
              i_funcionarios = w_i_funcionarios and
              dt_alteracoes = w_dt_alteracoes
          else
            insert into bethadba.hist_salariais( i_entidades,i_funcionarios,dt_alteracoes,i_niveis,i_clas_niveis,
              i_referencias,i_motivos_altsal,i_atos,salario,horas_mes,horas_sem) values( w_i_entidades,w_i_funcionarios,
              w_dt_alteracoes,w_i_niveis,w_i_clas_niveis,w_i_referencias,w_i_motivos_altsal,w_i_atos,w_salario,w_horas_mes,
              w_horas_sem);
          end if
        end if;
      else
    if exists(select 1 from bethadba.hist_salariais where
            i_entidades = w_i_entidades and
            i_funcionarios = w_i_funcionarios and
            dt_alteracoes = w_dt_alteracoes) then
          (select max(hour(dt_alteracoes)) into w_hora_alt from bethadba.hist_salariais where
            i_entidades = w_i_entidades and
            i_funcionarios = w_i_funcionarios and
            cast(dt_alteracoes as date) = cast(w_dt_alteracoes as date) ) ;
            set w_dt_alteracoes=cast(w_dt_alteracoes||w_hora_alt+1 as char)               
        end if;

        insert into bethadba.hist_salariais( i_entidades,i_funcionarios,dt_alteracoes,i_niveis,i_clas_niveis,
          i_referencias,i_motivos_altsal,i_atos,salario,horas_mes,horas_sem) values( w_i_entidades,w_i_funcionarios,
          w_dt_alteracoes,w_i_niveis,w_i_clas_niveis,w_i_referencias,w_i_motivos_altsal,w_i_atos,w_salario,w_horas_mes,
          w_horas_sem);
    	end if
	    end if;
    set w_i_funcionarios_aux=w_i_funcionarios;
	message 'Ent.: '||w_i_entidades||' Fun.: '||w_i_funcionarios||' Dt.: '||w_i_funcionarios to client;	
  end loop L_item;
  close cur_conver
end; 



commit