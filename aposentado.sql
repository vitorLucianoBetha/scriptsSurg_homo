-- BTHSC-61513 / Ajusta rescisões conforme base do concorrente, sendo possível enviar aposentados.

update bethadba.rescisoes r 
        left join tecbth_delivery.gp001_FUNCIONARIO f 
        on r.i_funcionarios = f.cdMatricula 
        set r.i_motivos_apos = f.CdDesligamento 
        where f.CdDesligamento in (16,17,18,19,20,21,22)





update bethadba.hist_funcionarios set prev_estadual = 'S', prev_federal = 'N', fundo_prev = 'N', fundo_ass = 'N', fundo_financ = 'N' where i_funcionarios IN (select  i_funcionarios from bethadba.rescisoes where i_motivos_apos is not null)

update bethadba.hist_funcionarios set i_vinculos = 14 where i_vinculos = 20