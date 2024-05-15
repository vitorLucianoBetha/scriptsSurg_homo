--------------------------------------------------
-- 09) Tipos Afast 
--------------------------------------------------
--BUG BTHSC-8050 Concatenar código do afastamento do banco concorrente com o nome do afastamento no concorrente

insert into bethadba.tipos_afast(i_tipos_afast,i_tipos_movpes,descricao,classif,perde_temposerv,busca_var,dias_prev)on existing skip
select number(*)+46,null,cdAfastamento||' - '||DsAfastamento,1,'N','N',null 
from tecbth_delivery.gp001_motivoafastamento 


--BUG BTHSC-6966
--where cdAfastamento in(6,7,8,9)
;
commit
;




INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(1, NULL, 'Licença com Vencimentos                           ', 2, 'S', 'S', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(2, NULL, 'Acidente trabalho típico previdência              ', 3, 'S', 'S', NULL, NULL, 0, 1);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(3, NULL, 'Serviço Militar                                   ', 4, 'S', 'N', NULL, NULL, 0, 29);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(4, NULL, 'Auxílio Maternidade                               ', 5, 'S', 'S', 120, NULL, 0, 17);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(5, NULL, 'Auxílio doença típico previdência                 ', 6, 'S', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(6, NULL, 'Licença sem Vencimentos                           ', 7, 'S', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(7, NULL, 'Demitido                                          ', 8, 'S', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(8, NULL, 'Aposentado                                        ', 9, 'S', 'S', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(9, NULL, 'Acidente trabalho típico empregador               ', 10, 'S', 'N', NULL, NULL, 0, 1);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(10, NULL, 'Acidente trabalho trajeto típico previdência      ', 11, 'S', 'S', NULL, NULL, 0, 1);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(11, NULL, 'Aux doença relacionada trabalho típico previdência', 12, 'S', 'N', NULL, NULL, 0, 1);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(12, NULL, 'Acidente trabalho trajeto típico empregador       ', 13, 'S', 'N', NULL, NULL, 0, 1);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(13, NULL, 'Auxílio doença típico empregador                  ', 14, 'S', 'N', NULL, NULL, 0, 3);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(14, NULL, 'Aux doença relacionada trabalho típico empregador ', 15, 'S', 'N', NULL, NULL, 0, 1);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(15, NULL, 'Prorrogação Motivo de Licença-Maternidade         ', 16, 'N', 'S', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(16, NULL, 'Aborto não Criminoso                              ', 17, 'N', 'S', NULL, NULL, 0, 19);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(17, NULL, 'Adoção/guarda judicial criança até 1 ano de idade ', 18, 'N', 'S', 120, NULL, 0, 20);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(18, NULL, 'Adoção/guarda judicial de criança de 1 a 4 anos   ', 19, 'N', 'S', 120, NULL, 0, 20);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(19, NULL, 'Adoção/guarda judicial de criança de 4 a 8 anos   ', 20, 'N', 'S', 120, NULL, 0, 20);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(20, NULL, 'Prorrogação Licença-Maternidade - Lei 11.770/2008 ', 21, 'N', 'S', 60, NULL, 0, 18);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(21, NULL, 'Aux. doença [até 15d] - COVID19                   ', 14, 'N', 'N', NULL, NULL, 0, 3);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(22, NULL, '1 - Licença Premio                                ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(23, NULL, '3 - N2 - TRANSFERENCIA DO EMPREGAD                ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(24, NULL, '4 - O1 - AFASTAMENTO TEMPORARIO PO                ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(25, NULL, '5 - O2 - NOVO AFASTAMENTO TEMPORAR                ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(26, NULL, '6 - Afast superior 15 dias RPPS                   ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(27, NULL, '8 - Afastamento Maternidade Q1                    ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(28, NULL, '11 - U3 - APOSENTADORIA POR INVALID               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(29, NULL, '13 - X - LICENCA SEM VENCIMENTOS                  ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(30, NULL, '14 - Y - OUTROS MOTIVOS DE AFASTAME               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(31, NULL, '15 - Y - OUTROS MOTIVOS DE AFASTAME               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(32, NULL, '21 - Prorrog Afast Maternidade RGPS               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(33, NULL, '24 - Afast Acidente Trabalho                      ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(34, NULL, '26 - Afast Inferior 15 Dias                       ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(35, NULL, '27 - AUX - AUXILIO DOENCA COM PAGAM               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(36, NULL, '28 - PRM - PERICIA MEDICA                         ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(37, NULL, '30 - Afast. Zera Pagamento                        ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(38, NULL, '31 - Prorrogação Maternidade                      ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(39, NULL, '32 - LMP - LICENCA MATERNIDADE PROR               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(40, NULL, '33 - PM - PERICA MEDICA S/TICKET                  ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(41, NULL, '35 - LAD - LICENCA ADOCAO EFETIVO                 ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(42, NULL, '36 - Afastamento Maternidade RPPS                 ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(43, NULL, '37 - Afast superior 15 dias RGPS                  ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(44, NULL, '38 - Afast.Cedencia                               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(45, NULL, '39 - Afast. Acidente Trabalho Efeti               ', 7, 'N', 'N', NULL, NULL, 0, NULL);
INSERT INTO Folharh.bethadba.tipos_afast
(i_tipos_afast, i_tipos_movpes, descricao, classif, perde_temposerv, busca_var, dias_prev, codigo_tce, dias_lim_rpps, classificacao_esocial)
VALUES(46, NULL, '99 - Redução Tempo Serviço                        ', 7, 'N', 'N', NULL, NULL, 0, NULL);


update bethadba.tipos_afast set descricao = (cast(i_tipos_afast as varchar(3)) + ' - ' + descricao) where i_tipos_afast <= 21
