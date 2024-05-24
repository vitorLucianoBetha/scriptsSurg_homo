update tecbth_delivery.gp001_CARGOFUNCAO set cdFuncao = 1054 where dsFuncao = 'Agente de Transito'
update tecbth_delivery.gp001_CARGOFUNCAO set cdFuncao = 1055 where dsFuncao = 'Desenhista'


select distinct cdFuncao as i_areas_atuacao,
dsfuncao as nome,
dsfuncao as descr_habilitacao, 
cdFuncao as codigo_tce,
null as atividades,
cdGrupoCboFuncao as i_cbo
from tecbth_delivery.gp001_CARGOFUNCAO order by i_areas_atuacao 

update bethadba.areas_atuacao set nome = (nome + ' - ' + cast(i_areas_atuacao as varchar(20))) where i_areas_atuacao in (1035,1041,1053, 2)


insert into bethadba.areas_atuacao_cargos  
select distinct
1 as i_entidades,
cdCargo as i_cargos, 
cdFuncao as i_areas_atuacao,
0 as qtd_vagas

from tecbth_delivery.gp001_CARGOFUNCAO order by i_areas_atuacao 