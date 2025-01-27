-- 129-movimentacao-pessoal
update bethadba.atos set dt_vigorar = '2001-01-01' where i_atos = 61

-- 30-funcionario
update bethadba.locais_mov set principal = 'S' where principal = 'N'

--133 fechamento folha
update bethadba.dados_calc set dt_fechamento = dt_pagto where dt_fechamento is null

--153 - Lotação
UPDATE locais_mov
SET principal = 'N';

UPDATE locais_mov
SET principal = 'S'
FROM locais_mov AS t1
WHERE t1.dt_inicial = (
    SELECT MAX(t2.dt_inicial)
    FROM locais_mov AS t2
    WHERE t2.i_funcionarios = t1.i_funcionarios
);

--174 organograma
update bethadba.niveis_organ set num_digitos = 1 where i_niveis_organ = 1
update bethadba.niveis_organ set num_digitos = 5 where i_niveis_organ = 2