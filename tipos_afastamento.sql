--------------------------------------------------
-- 09) Tipos Afast 
--------------------------------------------------
--BUG BTHSC-8050 Concatenar código do afastamento do banco concorrente com o nome do afastamento no concorrente
insert into bethadba.tipos_afast(i_tipos_afast,i_tipos_movpes,descricao,classif,perde_temposerv,busca_var,dias_prev)on existing skip
WITH max_code AS (
    SELECT MAX(cdAfastamento) AS max_cdAfastamento
    FROM tecbth_delivery.gp001_motivoafastamento
),
ausencia_with_rownum AS  (
    SELECT 
        cdAusencia, 
        dsAusencia,
        ROW_NUMBER() OVER (ORDER BY cdAusencia) AS rn
    FROM tecbth_delivery.gp001_AUSENCIA
)
SELECT 
    cdAfastamento AS cdAfastamento,
    NULL AS i_tipos_movpes,
    cdAfastamento || ' - ' || DsAfastamento AS descricao,
    1 AS classif,
    'N' AS perde_temposerv,
    'N' AS busca_var,
    NULL AS dias_prev
FROM tecbth_delivery.gp001_motivoafastamento

UNION ALL

SELECT 
    (SELECT max_cdAfastamento FROM max_code) + rn AS cdAusencia,
    NULL AS  i_tipos_movpes,
    cdAusencia || ' - ' || dsAusencia AS descricao,
    1 AS col4,
    'N' AS perde_temposerv,
    'N' AS busca_var,
    NULL AS dias_prev
FROM ausencia_with_rownum

commit;