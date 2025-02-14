CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;

alter table gp001_tipodesligamento add (i_motivos_resc integer);

insert into bethadba.motivos_resc(i_motivos_resc,i_tipos_movpes,descricao,dispensados,sair_fumbesc,num_caged,motivo_rais,cod_saque_fgts,movto_gfip,i_tipos_afast,
								  i_tipos_movpes_subst)on existing skip
select cdDesligamento,null,DsDesligamento,5,'N',CdCaged,CdRais,null,null,7,null from tecbth_delivery.gp001_tipodesligamento 

;

--BTHSC-145660  inserido item 15

update gp001_tipodesligamento 
set i_motivos_resc = case 
                      when CdDesligamento = 1 then 2 
                      when CdDesligamento = 2 then 1  
                      when CdDesligamento = 3 then 16 
                      when CdDesligamento = 4 then 7  
                      when CdDesligamento = 5 then 4  
                      when CdDesligamento = 6 then 17 
                      when CdDesligamento = 7 then 12 
                      when CdDesligamento = 8 then 18 
                      when CdDesligamento = 9 then 19 
                      when CdDesligamento = 10 then 8 
                      when CdDesligamento = 11 then 20 
                      when CdDesligamento = 12 then 21 
                      when CdDesligamento = 13 then 22 
                      when CdDesligamento = 14 then 23 
                      when CdDesligamento = 15 then 15 
                      else i_motivos_resc
                    end
where i_motivos_resc is null;
commit
;

