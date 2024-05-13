insert into bethadba.fatores
select 
cdFator as i_fatores,
dsFator as nome,
dsFator as descricao,
nrPeso as peso
from tecbth_delivery.gp001_av_fator where cdAvaliacao = 1


