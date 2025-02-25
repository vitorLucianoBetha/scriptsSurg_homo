CALL bethadba.pg_habilitartriggers('off');
CALL bethadba.pg_setoption('fire_triggers', 'off');
COMMIT;

INSERT INTO pessoas_contas (pessoas, sequencia, nrbancocc, nragenciacc, conta, status, tipo)
SELECT  
    pessoas,
    ROW_NUMBER() OVER (
        PARTITION BY pessoas 
        ORDER BY nrbancocc, nragenciacc, conta
    ) AS sequencia,
    nrbancocc,
    nragenciacc,
    conta,
    1,
    'A'
FROM (
    SELECT DISTINCT
        (SELECT i_pessoas FROM funcionarios WHERE i_funcionarios = cdMatricula) AS pessoas,
        nrbancocc,
        nragenciacc,
        nrcontacorrente || dgcontacorrente AS conta,
        tpcontacc
    FROM 
        tecbth_delivery.gp001_HISTORICOBANCARIO
    WHERE 
        nrcontacorrente IS NOT NULL 
        AND nrcontacorrente != ''
    GROUP BY 
        nrbancocc,
        nragenciacc,
        nrcontacorrente,
        dgcontacorrente,
        tpcontacc,
        cdMatricula
) AS consulta
WHERE 
    conta IS NOT NULL 
    AND conta != ''
ORDER BY 
    pessoas;
