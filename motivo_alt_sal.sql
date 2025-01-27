
;
if not exists (select 1 from sys.syscolumns where creator = current user  and tname = 'gp001_MotivoEvolucao' and cname = 'w_i_motivos_alt_sal_new') then 
	alter table gp001_MotivoEvolucao add(w_i_motivos_alt_sal_new integer);
end if
;
update gp001_MotivoEvolucao set w_i_motivos_alt_sal_new = cdmotivo 
;
insert into bethadba.motivos_altsal(i_motivos_altsal,descricao,codigo_tce)on existing skip
select w_i_motivos_alt_sal_new,DsMotivo,null from gp001_MotivoEvolucao;
commit
;

if  exists (select 1 from sys.sysprocedure where creator = (select user_id from sys.sysuserperms where user_name = current user) and proc_name = 'cnv_hist_salarial') then
	drop procedure cnv_hist_salarial;
end if
;



CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit','on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;



INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(1, 'Admissão                                ', 1);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(2, 'Inflação Mensal                         ', 2);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(3, 'Promoção de Cargo                       ', 3);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(4, 'Progressão de Faixa                     ', 4);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(5, 'Dissídio Coletivo                       ', 5);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(6, 'Folha Simulada                          ', 6);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(7, 'Promoção                                ', 7);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(8, 'Reajuste Salarial                       ', 8);
INSERT INTO Folharh.bethadba.motivos_altsal
(i_motivos_altsal, descricao, codigo_tce)
VALUES(9000, 'Cálc. Sal. Retroat.                     ', 9000);

