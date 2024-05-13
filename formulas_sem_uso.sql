delete bethadba.formulas_calc 
where trim(descricao) = ''
;

insert into bethadba.formulas_calc on existing skip
(select i_eventos,'valor vaux = valorvar(codeve);\x0D\x0Avlrref = vaux;\x0D\x0A\x0D\x0Avlrcalc = vaux;\x0D\x0A','11','','','','','35','','' 
 from bethadba.eventos
 where i_eventos not in (select i_eventos 
						 from bethadba.formulas_calc))
;

commit
;