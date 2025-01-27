insert into bethadba.tipos_movpes(i_tipos_movpes,descricao,classif,codigo_tce)on existing skip
select CdTipoMovimentoAto,DsTipoMovimentoAto,0,null 
from tecbth_delivery.gp001_AtoTipoMovimento
;            
 
commit
;


rollback;


UPDATE BETHADBA.tipos_movpes SET classif = 1 WHERE i_tipos_movpes = 1