insert into bethadba.dependentes 
select 
2 as i_dependentes ,
i_pessoas as i_pessoas ,
9 as grau,
null as dt_casamento,
'2000-01-01' as dt_ini_depende,
null as mot_ini_depende,
null as dt_fin_depende,
null as mot_fin_depende,
null as ex_conjuge,
null as descricao
from bethadba.funcionarios where tipo_func = 'B'