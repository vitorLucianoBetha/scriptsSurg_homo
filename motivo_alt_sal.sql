
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

ROLLBACK;
CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit','on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;



INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(1, 'S', 'Admissão', '', '', 1);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(2, 'S', 'Inflação Mensal', '', '', 2);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(3, 'S', 'Promoção de Cargo', '', '', 3);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(4, 'S', 'Progressão de Faixa', '', '', 4);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(5, 'S', 'Dissídio Coletivo', '', '', 5);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(6, 'S', 'Folha Simulada', '', '', 6);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(7, 'S', 'Promoção', '', '', 7);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(8, 'S', 'Reajuste Salarial', '', '', 8);
INSERT INTO Folharh.tecbth_delivery.gp001_MotivoEvolucao
(CdMotivo, inAvaliacao, DsMotivo, inEnquadramento, inSistema, w_i_motivos_alt_sal_new)
VALUES(9000, 'S', 'Cálc. Sal. Retroat.', '', 'S', 9000);
