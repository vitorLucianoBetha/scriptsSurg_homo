CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;

insert into bethadba.tipos_aval_grupos_aval
select
cdAvaliacao as i_tipos_aval ,
6 as i_tipos_avaliacao,
1 as qtd_avaliacoes,
nrNotaMaxima as peso_avaliacao,
1 as limite_preenc,
1 as limite_preenc_venc,
'N' as avaliador_decl,
'N' as DEFERIMENTO_RH,
1 as comissoes_aval
from tecbth_delivery.gp001_AV_AVALIACAO

