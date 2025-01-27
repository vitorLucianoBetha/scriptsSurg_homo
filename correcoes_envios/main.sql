-- Entidades
update bethadba.entidades set cnpj = '03845124000166'
update bethadba.hist_entidades set cnpj = '03845124000166'
update bethadba.hist_entidades_software_house set cnpj = '00456865000167'
update bethadba.hist_entidades_compl set i_pessoas = 6 where i_entidades = 1
update bethadba.tipos_adm set i_naturezas = 1244

-- Atos 
update bethadba.atos set i_natureza_texto_juridico = 5 where i_natureza_texto_juridico is null

-- Organogramas
update bethadba.config_organ set nivel_orgao = 1, nivel_unid = 2, nivel_sec = 1
update bethadba.config_organ set nivel_orgao = 1, nivel_unid = 2, nivel_sec = 1

update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '000001000' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '00000102' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '000001020' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '00000103' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '000001030' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '00000104' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '000001040' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '00000105' and tipo_registro = 'organograma'
update bethadba.controle_migracao_registro set id_gerado = '660942' where i_chave_dsk2 = '000001050' and tipo_registro = 'organograma'


-- Pessoa
update bethadba.hist_pessoas_fis set cpf = null where i_pessoas in (150)
update bethadba.hist_pessoas_fis set num_pis  = null where i_pessoas in (150)
UPDATE bethadba.hist_pessoas_fis
SET num_pis = NULL
WHERE i_pessoas IN (21, 193, 190, 183, 179, 169, 155, 165, 94, 48, 197, 44, 27, 24, 22, 135, 49, 45, 30, 28, 25, 23, 29, 200);


-- Encargos sociais
update bethadba.hist_parametros_previd set desoneracao_folha = '0' where desoneracao_folha is null

-- Niveis
update bethadba.hist_cargos_compl set i_referencias_ini = 1, i_referencias_fin = 1 where i_niveis = 1
update bethadba.hist_cargos_compl set i_referencias_ini = 1, i_referencias_fin = 1 where i_niveis = 1001
    
update bethadba.niveis set dt_criacao = dt_criacao - 1


-- Cargos
update bethadba.cargos_compl set i_config_ferias = 1, i_config_ferias_subst = 1 where i_config_ferias is null


-- Afastamento
update bethadba.afastamentos set i_tipos_afast= 18 where i_tipos_afast = 7
UPDATE Folharh.bethadba.tipos_afast
SET classif=3
WHERE i_tipos_afast=1;
UPDATE Folharh.bethadba.tipos_afast
SET classif=3
WHERE i_tipos_afast=2;
UPDATE Folharh.bethadba.tipos_afast
SET classif=4
WHERE i_tipos_afast=3;
UPDATE Folharh.bethadba.tipos_afast
SET classif=5
WHERE i_tipos_afast=4;
UPDATE Folharh.bethadba.tipos_afast
SET classif=7
WHERE i_tipos_afast=5;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=6;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=7;
UPDATE Folharh.bethadba.tipos_afast
SET classif=7
WHERE i_tipos_afast=8;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=9;
UPDATE Folharh.bethadba.tipos_afast
SET classif=5
WHERE i_tipos_afast=10;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=11;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=12;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=13;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=14;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=15;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=16;
UPDATE Folharh.bethadba.tipos_afast
SET classif=2
WHERE i_tipos_afast=17;
UPDATE Folharh.bethadba.tipos_afast
SET classif=8
WHERE i_tipos_afast=18;


-- Rescisão
update bethadba.rescisoes set i_motivos_apos = 18


-- Pensionista
update bethadba.hist_funcionarios set prev_estadual = 'S', prev_federal = 'N', fundo_prev = 'N', fundo_ass = 'N' where i_funcionarios in (select i_funcionarios from bethadba.funcionarios where tipo_func = 'B')