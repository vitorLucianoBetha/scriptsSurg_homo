
insert into bethadba.tipos_aval
select
cdAvaliacao as i_tipos_aval,
dsAvaliacao as descricao,
1 as num_aval,
'M' as resultado_ciclo_,
70 as resul_APROV,
nrNotaMaxima as pontuacao_max,
2 as classif_tipoaval,
30 as diasret_aval,
60 as diasret_ultaval,
'N' AS afast_prorrog_aval,
'N' AS afast_procadm,
'2' as cargocom_avalext,
'N' AS perm_transf,
'N' AS troca_cargo,
null as dias_afa_procadm,
null as dias_afa_avalext,
'N' as cid_procadm,
null as i_tipos_aval_suc_aprov,
null as i_tipos_aval_suc_reprov,
'M' AS resultado_aval,
nrNotaMaxima as pontuacao_max_ciclo,
2 as metodo_aval,
'N' as ABRIR_CICLO_ADM_SERV_CONCURSADO,
'N' as abrir_ciclo_adm_serv_ocupa_vaga,
'N' as abrir_ciclo_adm_todos_serv,
1 AS layout_web,
null as legenda_resultado,
'N' as considera_afim
from tecbth_delivery.gp001_AV_AVALIACAO