insert into bethadba.motivos_resc(i_motivos_resc,i_tipos_movpes,descricao,dispensados,sair_fumbesc,num_caged,motivo_rais,cod_saque_fgts,movto_gfip,i_tipos_afast,
								  i_tipos_movpes_subst)on existing skip
select number(*)+15,null,DsDesligamento,5,'N',CdCaged,CdRais,null,null,7,null from tecbth_delivery.gp001_tipodesligamento 

;
alter table gp001_tipodesligamento add (i_motivos_resc integer);
update gp001_tipodesligamento 
set i_motivos_resc = if CdDesligamento = 1 then 2 else
                      if CdDesligamento = 2 then 1 else  
                      if CdDesligamento = 3 then 16 else
                      if CdDesligamento =  4 then 7 else  
                      if CdDesligamento = 5 then 4 else  
                      if CdDesligamento = 6 then 17 else 
                      if CdDesligamento = 7 then 12 else 
                      if CdDesligamento = 8 then 18 else 
                      if CdDesligamento = 9 then 19 else 
                      if CdDesligamento = 10 then 8 else 
                      if CdDesligamento = 11 then 20 else 
                      if CdDesligamento = 12 then 21 else 
                      if CdDesligamento = 13 then 22 else 
                      if CdDesligamento = 14 then 23 endif endif endif endif endif endif endif endif endif endif endif endif endif endif
where i_motivos_resc is null;
commit
;
alter table gp001_tipodesligamento add i_motivos_apos integer;
update gp001_tipodesligamento set i_motivos_apos = 3 where CdDesligamento = 4;
commit
;



INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(1, 'N', 'H - RESC COM JUSTA CAUSA POR INICIATIVA DO EMPREGA', 10, 32, 'N', 0, 0, 1, 2, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(2, 'N', 'I - RESC SEM JUSTA CAUSA POR INICIATIVA DO EMPREGA', 11, 0, 'S', 4, 30, 3, 1, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(3, 'S', 'I1 - RESC SEM JUSTA CAUSA POR INICIATIVA DO EMPREG', 11, 31, 'S', 4, 30, 3, 16, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(4, 'S', 'I2 - RESCISAO POR CULPA RECIPROCA OU FORCA MAIOR  ', 10, 0, 'S', 4, 30, 27, 7, 3);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(5, 'S', 'I3 - RESCISAO POR FINALIZACAO DO CONTRATO A TERMO ', 12, 0, 'N', 4, 0, 6, 4, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(6, 'S', 'I4 - RESCISAO SEM JUSTA CAUSA DO CONTRATO DE TRABA', 11, 0, 'S', 4, 30, 2, 17, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(7, 'N', 'J - RESCISAO DO CONTRATO DE TRABALHO POR INICIATIV', 21, 40, 'N', 4, 0, 7, 12, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(8, 'N', 'K - RESCISAO A PEDIDO DO EMPREGADO OU POR INICIATI', 20, 0, 'S', 4, 30, 1, 18, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(9, 'S', 'L - OUTROS MOTIVOS DE RESCISAO DO CONTRATO DE TRAB', 21, 0, 'N', 4, 0, 7, 19, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(10, 'N', 'M - MUDANCA DE REGIME ESTATUTARIO                 ', 40, 0, 'S', 4, 0, 30, 8, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(11, 'N', 'S - FALECIMENTO (EXTINTO EM 01/10/2003)           ', 60, 60, 'N', 4, 30, 10, 20, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(12, 'N', 'U1 - APOSENTADORIA                                ', 70, 30, 'N', 4, 30, 38, 21, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(13, 'N', 'U2 - APOSENTADORIA POR TEMPO DE CONTRIBUICAO OU ID', 70, 0, 'N', 4, 0, 38, 22, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(14, 'N', 'S2 - FALECIMENTO                                  ', 60, 0, 'N', 4, 0, 10, 23, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(15, 'N', 'S3 - FALECIMENTO MOTIVADO POR ACIDENTE DE TRABALHO', 73, 0, 'N', 4, 0, 38, NULL, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(16, 'S', 'I5 - RESCISAO POR ACORDO                          ', 90, 90, 'S', 4, 0, 33, NULL, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(17, 'N', '### - RESCISAO (USADO NA MIGRACAO) SERVIDOR COM DA', 30, 30, 'N', 4, 0, 30, NULL, NULL);
INSERT INTO Folharh.tecbth_delivery.gp001_TipoDesligamento
(CdDesligamento, InRecolheGrfp, DsDesligamento, CdRais, CdCaged, InAvisoPrevio, cdTipoMediaAvisoPrevio, nrDiasAvisoPrevio, cdMtvDeslig_eSocial, i_motivos_resc, i_motivos_apos)
VALUES(18, 'N', '36 - MUDANCA DE CPF                               ', 0, 0, 'S', 4, 0, 36, NULL, NULL);



INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(1, NULL, 'Dispensa COM justa causa                ', '1', 'S', '32', '10', NULL, 'H', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(2, NULL, 'Dispensa SEM justa causa                ', '1', 'S', '31', '11', '01', 'I1', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(3, NULL, 'Pedido de demissão COM justa causa      ', '2', 'S', '40', '20', NULL, 'K', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(4, NULL, 'Pedido de demissão SEM justa causa      ', '2', 'S', '40', '21', NULL, 'K', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(5, NULL, 'Cessão do funcionário                   ', '1', 'S', '80', '31', '04', 'K', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(6, NULL, 'Transferência do funcionário            ', '1', 'S', '80', '31', NULL, 'N2', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(7, NULL, 'Aposentadoria                           ', '3', 'S', '50', '70', '05', 'U1', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(8, NULL, 'Morte                                   ', '4', 'N', '60', '60', '23', 'S2', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(9, NULL, 'Outros casos                            ', '2', 'N', '45', '12', NULL, 'L', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(10, NULL, 'Resc.contrato experiência ant.pelo órgão', '1', 'S', '31', '12', NULL, 'I1', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(11, NULL, 'Resc. contrato exper. ant. pelo funcion.', '2', 'S', '40', '12', NULL, 'J', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(12, NULL, 'Término do contrato de experiência      ', '1', 'S', '45', '12', NULL, 'L', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(13, NULL, 'Morte por acidente de trabalho          ', '4', 'N', '60', '62', '23', 'S3', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(14, NULL, 'Morte por doença profissional           ', '4', 'N', '60', '64', '23', 'S2', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(15, NULL, 'Encerramento de Contrato (sem cálculo)  ', '5', 'N', '45', '12', NULL, 'L', 7, NULL, NULL, 'N', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(16, NULL, 'Término de Contrato-Conselheiro Tutelar ', '1', 'N', NULL, NULL, NULL, NULL, 7, NULL, NULL, 'S', 'N', 'N', '02', NULL);
INSERT INTO Folharh.bethadba.motivos_resc
(i_motivos_resc, i_tipos_movpes, descricao, dispensados, sair_fumbesc, num_caged, motivo_rais, cod_saque_fgts, movto_gfip, i_tipos_afast, i_tipos_movpes_subst, rescisao_fly_transparencia, exc_conselheiro_tutelar, nulidade_contratotrab, exoneracao, categoria_esocial, motivo_desligamento_tsve)
VALUES(17, NULL, 'Conselheiro Tutelar - Sem Cálculo       ', '1', 'N', NULL, NULL, NULL, NULL, 7, NULL, NULL, 'S', 'N', 'N', '02', NULL);
