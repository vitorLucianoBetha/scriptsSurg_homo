
if exists(select 1 from sys.sysprocedure where proc_name = 'permite_usuario' and creator = (select user_id from sys.sysuserperms where user_name = current user)) then
    drop procedure permite_usuario;
end if
;

create procedure permite_usuario(ps_usuario varchar(20),ps_grant varchar(10))
begin
	declare w_cmd long varchar;
	ooLoop: for oo as w_perm_user dynamic scroll cursor for 
			select distinct tname as w_tabela 
			from sys.syscolumns 
			where creator = current user 
	do
		set w_cmd = 'grant '||ps_grant||' on '||current user||'.'||w_tabela||' to '||ps_usuario;
		message w_cmd to client;
		execute immediate w_cmd;
	end for
end
;

call permite_usuario('tecbth_atb','all')
;
call permite_usuario('admin','SELECT')
;
call permite_usuario('externo','SELECT')
;

if exists(select 1 from sys.sysprocedure where proc_name = 'permite_usuario' and creator = (select user_id from sys.sysuserperms where user_name = current user)) then
    drop procedure permite_usuario;
end if

commit

 call bethadba.pg_setoption('fire_triggers','off'); update bethadba.dados_calc

SET dt_fechamento = date(year(i_competencias)|| (if month(i_competencias) < 10 THEN '0'+cast(month(i_competencias) AS varchar) else cast(month(i_competencias) AS varchar) endif)|| (if month(i_competencias) = 2 THEN '28' else '30' endif))
WHERE i_competencias < 20230501 
AND dt_fechamento is null; update bethadba.processamentos 

SET dt_fechamento = date(year(i_competencias)|| (if month(i_competencias) < 10 THEN '0'+cast(month(i_competencias) AS varchar) else cast(month(i_competencias) AS varchar) endif)|| (if month(i_competencias) = 2 THEN '28' else '30' endif))
WHERE i_competencias < 20230501 
AND dt_fechamento is null; update bethadba.processamentos 

SET pagto_realizado = 'S'
WHERE i_competencias < 20230501 
AND pagto_realizado = 'N'; commit; call bethadba.pg_setoption('fire_triggers','on'); 


INSERT INTO "bethadba"."formacoes"
select number (*) ,* from (SELECT  distinct dsareaestagio as nome, null as sigla_conselho,3 as nivel_formacao, 'N' AS seguranca_trab, NULL AS uf_conselho 
 FROM tecbth_delivery.gp001_FuncionarioEstagio )kdkd


