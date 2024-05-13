/* 94 - Funcionarios */ 
UPDATE bethadba.locais_mov
SET principal  = 'S'
WHERE dt_Inicial = (
    SELECT MAX(dt_Inicial)
    FROM bethadba.locais_mov AS lm
    WHERE lm.i_funcionarioS = bethadba.locais_mov.i_funcionarioS
)


/* 61-Dependentes */
update bethadba.dependentes set mot_fin_depende = 0 where dt_fin_depende is not null

/* 102-Logradouros */ 
update bethadba.pessoas_enderecos pe 
left join bethadba.ruas ru 
on pe.i_ruas = ru.i_ruas 
set pe.nome_rua = ru.nome 
where pe.nome_rua is null 

update bethadba.pessoas_enderecos pe 
left join bethadba.ruas ru 
on pe.i_ruas = ru.i_ruas 
set pe.nome_rua = ru.nome 
where pe.nome_rua = '' 

-- 35-Atos
update bethadba.atos set i_natureza_texto_juridico = 16 where i_natureza_texto_juridico is null

-- 156-Dependentes
update bethadba.dependentes_func set dep_irrf = 'N' where i_dependentes in (1723,1876)

-- 155-Dependentes
update bethadba.dependentes set mot_ini_depende = 0 where mot_ini_depende is null

-- 157-Endereços
update bethadba.pessoas_enderecos set i_cidades = 4109401 where i_cidades is null
update bethadba.pessoas_enderecos set i_bairros = 2 where i_bairros is null
update bethadba.pessoas_enderecos set i_ruas = 3 where i_ruas is null

-- 154-Dependentes

update bethadba.dependentes d 
left join bethadba.pessoas_fisicas pf 
on d.i_pessoas = pf.i_pessoas 
set d.dt_ini_depende = pf.dt_nascimento 
where d.dt_ini_depende is null

-- 88-Dependentes

update bethadba.dependentes d 
left join bethadba.pessoas_fisicas pf 
on d.i_dependentes  = pf.i_pessoas 
set d.dt_ini_depende = pf.dt_nascimento + 365
where d.dt_ini_depende < PF.dt_nascimento 


-- 117-FUNCIONARIOS
INSERT INTO bethadba.hist_salariais 
SELECT 
    1 as i_entidades,
    Funcionario.CdMatricula as i_funcionarios,
    IF DtHistorico IS NULL THEN dtAdmissao + 1 ELSE dtgeracao + 1 ENDIF as dt_alteracoes,
    NULL as i_niveis,
    NULL as i_clas_niveis,
    NULL as i_referencias,
    cdMotivo as i_motivos_altsal,
    NULL as i_atos,
    IF VlSalario = 0 THEN 1 ELSE VlSalario ENDIF as salario,
    CAST("truncate"(CAST((nrdias-1)*NrHorasDia*5 as DECIMAL(5,2)), 2) as INTEGER) as horas_mes,
    horas_mes/5 as horas_sem,
    NULL as observacao,
    NULL as controle_jornada_parc,
    NULL as deduz_iss, 
    NULL as aliq_iss, 
    NULL as qtd_dias_servico,
    NULL as dt_alteracao_esocial,
    dt_alteracoes as dt_chave_esocial
from  tecbth_delivery.gp001_Funcionario as Funcionario,tecbth_delivery.gp001_HistoricoSalarial as HistoricoSalarial,tecbth_delivery.gp001_Escala as Escala 
where  Funcionario.CdMatricula *= HistoricoSalarial.CdMatricula 
  and  Funcionario.SqContrato *= HistoricoSalarial.SqContrato 
  and funcionario.cdMatricula in (110078,110132,110213,110221,110256,110264,110272,120022,130010,130036,130052,130060,130079,130087,130095,130117,130125,130150,130184,130230,130257,130281,130311,130362,130400,130419,130516,130532,130540,130567,130613,130648,130796,130826,130915,131016,131059,131121,131130,131180,131210,131334,131377,131482,131520,131571,131857,131920,131954,132020,132047,132101,132195,132241,132268,132276,132292,132314,132349,132365,132438,132462,132470,132551,132594,132608,132632,132640,132713,132730,132748,132756,132802,132810,132900,132934,132969,133027,133272,133310,133396,133442,133493,133507,133540,133639,133663,133710,133833,133841,133884,133892,133906,133949,133965,134015,134066,134090,134120,134210,134252,134279,134414,134422,134430,134511,134562,134619,134635,134643,134678,134767,134813,134830,134848,134872,134880,134899,134902,134937,134945,134953,134988,134996,135160,135216,135232,135283,135305,135321,135348,135380,135402,135453,135470,135526,135593,135607,135623,135631,135666,135690,135704,135739,135747,135780,135798,135801,135810,135828,135836,135844,135879,135887,135895,135933,135941,136948,136956,136972,136999,137006,137014,137022,137030,137057,137065,137090,137111,137120,137138,137146,137162,137170,137189,137197,137219,137243,137251,137286,137294,137308,137316,137332,137340,137359,137367,137375,137383,137391,137405,137421,137430,137448,137456,137472,137502,137545,137553,137570,137588,137600,137626,137642,137650,137669,137677,137685,137707,137715,137723,137731,137740,137758,137766,137782,137790,137804,137812,137820,137839,137847,137855,137863,137871,137880,137898,137901,137910,137928,137944,137960,137995,138002,138010,138029,138037,138045,138053,138061,138088,138096,138100,138118,138126,138134,138142,138150,138169,138177,138185,138193,138215,138223,138231,138240,138258,138266,138274,138282,138290,138304,138312,138320,138347,138355,138363,138428,138436,138444,138452,138479,138487,138495,138509,138517,138525,138533,138550,138568,138576,138584,138606,138614,138649,138657,138673,138681,138690,138720,138738,138746,138754,138770,138789,138797,138827,138835,138843,138851,138860,138908,138916,138932,138940,138959,138967,138975,138983,138991,139009,139025,139041,139050,139068,139084,139092,139114,139122,139130,139149,139157,139173,139181,139190,139203,139220,139238,139270,139297,139300,139335,139343,139360,139378,139386,139394,139416,139432,139459,139467,139483,139491,139513,139548,139556,139564,139572,139599,139610,139629,139637,139645,139661,139688,139696,139700,139734,139769,139777,139793,139807,139815,139823,139831,139840,139858,139890,139904,139920,139939,139971,139998,140007,140015,140023,140031,140040,140082,140090,140120,140147,140155,140163,140171,140198,140201,140210,140228,140244,140252,140260,140287,140309,140325,140350,140368,140376,140414,140430,140457,140465,140473,140503,140511,140538,140546,140554,140562,140570,140597,140600,140627,140635,140643,140660,140678,140708,140716,140724,140732,140759,140767,140783,140791,140805,140813,140821,140830,140848,140856,140864,140880,140910,140929,140945,140953,140961,140970,140988,150010,150029,150037,150045,150053,150088,150096,150100,150126,150142,150150,150177,150185,150193,150207,150240,150258,150266,150282,150304,150312,150320,150339,150355,150363,150380,150398,150401,150444,150460,150479,150495,150509,150525,150533,150541,150550,150568,150576,150584,150592,150606,150614,150622,150630,150649,150657,150665,150681,150690,150703,150711,150720,150762,150827,150860,150878,150894,150908,150940,150991,160016,160024,160075,160083,160091,160121,160130,160156,160180,160202,160210,160229,160245,160253,160261,160270,160288,160300,160318,160326,160342,160369,160377,160385,160393,160415,160423,160431,160474,160482,160490,160504,160547,160580,160644,160660,160679,160687,160695,160709,160725,160741,160784,160792,160806,160814,160822,160830,160849,160857,160865,160873,160881,160920,160938,160970,160989,170003,170020,170038,170062,170089,170135,170143,170160,170186,170194,170208,170224,170232,170259,170267,170275,170283,170291,170313,170321,170330,170356,170364,170380,170429,170445,170453,170496,170500,170534,170585,170593,170615,170631,170658,170666,170674,170682,170704,170720,170747,170780,170828,170852,170860,170887,170976,170992,180009,180017,180025,180041,180068,180084,180122,180190,180203,180211,180254,180270,180289,180300,180343,180386,180394,180408,180416,180459,180556,180572,180580,180645,180653,180661,180688,180700,180742,180769,180890,180955,180998,190071,190098,190110,190225,190349,190357,190381,190470,190594,190624,190640,190659,190705,190780,191558,191566,191604,191612,191787,191795,191833,191841,191850,191868,191876,191884,191892,191906,191914,191922,191930,191949,192112,192120,192287,192406,192465,192473,192481,192554,192562,192570,192589,192597,192600,192619,192627,192635,192643,192651,192660,192775,192783,192791,192805,192813,192821,192848,192864,192872,192880,192899,192902,192910,20060,20079,20095,20109,20117,20141,20150,20168,20176,20184,20192,20206,20214,20222,20230,20249,20257,20265,20273,20281,20290,20303,20311,20320,20338,20346,20354,20362,20370,20389,20397,20400,20419)
  and  Funcionario.CdEscalaTrabalho = Escala.CdEscala 
and NOT EXISTS (
    SELECT 1 
    FROM bethadba.hist_salariais AS hs 
    WHERE hs.i_entidades = 1
    AND hs.i_funcionarios = Funcionario.CdMatricula
    -- Adicione mais condições conforme necessário para verificar a unicidade dos registros
);




CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;

INSERT INTO bethadba.hist_salariais 
SELECT 
    1 as i_entidades,
    Funcionario.CdMatricula as i_funcionarios,
    IF DtHistorico IS NULL THEN dtAdmissao + 1 ELSE dtgeracao + 1 ENDIF as dt_alteracoes,
    NULL as i_niveis,
    NULL as i_clas_niveis,
    NULL as i_referencias,
    cdMotivo as i_motivos_altsal,
    NULL as i_atos,
    IF VlSalario = 0 THEN 1 ELSE VlSalario ENDIF as salario,
    CAST("truncate"(CAST((nrdias-1)*NrHorasDia*5 as DECIMAL(5,2)), 2) as INTEGER) as horas_mes,
    horas_mes/5 as horas_sem,
    NULL as observacao,
    NULL as controle_jornada_parc,
    NULL as deduz_iss, 
    NULL as aliq_iss, 
    NULL as qtd_dias_servico,
    NULL as dt_alteracao_esocial,
    dt_alteracoes as dt_chave_esocial
FROM  tecbth_delivery.gp001_Funcionario as Funcionario, tecbth_delivery.gp001_HistoricoSalarial as HistoricoSalarial, tecbth_delivery.gp001_Escala as Escala 
WHERE  Funcionario.CdMatricula *= HistoricoSalarial.CdMatricula 
  AND  Funcionario.SqContrato *= HistoricoSalarial.SqContrato 
  AND funcionario.cdMatricula IN ()
  AND  Funcionario.CdEscalaTrabalho = Escala.CdEscala 
AND NOT EXISTS (
    SELECT 1 
    FROM bethadba.hist_salariais AS hs 
    WHERE hs.i_entidades = 1
    AND hs.i_funcionarios = Funcionario.CdMatricula
);
-- 140660, 140767
-- Adicione a linha abaixo para imprimir os i_funcionarios inseridos



-- 111-Ferias
DELETE FROM bethadba.ferias
WHERE EXISTS (
    SELECT 1
    FROM bethadba.ferias b
    WHERE bethadba.ferias.i_entidades = b.i_entidades
      AND bethadba.ferias.i_funcionarios = b.i_funcionarios
      AND (bethadba.ferias.dt_gozo_ini BETWEEN b.dt_gozo_ini AND b.dt_gozo_fin
           OR bethadba.ferias.dt_gozo_fin BETWEEN b.dt_gozo_ini AND b.dt_gozo_fin)
      AND (bethadba.ferias.dt_gozo_ini <> b.dt_gozo_ini OR bethadba.ferias.dt_gozo_fin <> b.dt_gozo_fin)
)
AND bethadba.ferias.i_entidades = 1;


-- 140-periodo-ferias



--70 Funcionarios
update bethadba.ferias set dt_gozo_fin = '2004-04-02' where i_funcionarios = 160075


--119-variaveis
delete from bethadba.variaveis  where i_funcionarios in (20320    ,                                                                                                                       
191558                                                                ,                                                          
191558                                                                 ,                                                         
192864                                                                                                                          ) 


-- 149 férias



DELETE FROM bethadba.dados_calc
WHERE i_entidades IN (1)
  AND i_tipos_proc = 80
  AND dt_fechamento IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM bethadba.ferias_proc fp
    LEFT JOIN bethadba.ferias f ON fp.i_entidades = f.i_entidades 
                                 AND fp.i_funcionarios = f.i_funcionarios 
                                 AND fp.i_ferias = f.i_ferias
    WHERE dados_calc.i_entidades = fp.i_entidades 
      AND dados_calc.i_funcionarios = fp.i_funcionarios 
      AND dados_calc.i_tipos_proc = fp.i_tipos_proc 
      AND dados_calc.i_processamentos = fp.i_processamentos 
      AND dados_calc.i_competencias = fp.i_competencias
  );
