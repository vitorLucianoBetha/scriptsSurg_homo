insert into bethadba.tipos_atos(i_tipos_atos,nome,classif,gera_tc, codigo_docto_tce, codigo_assunto_tce, codigo_tce)
select distinct CdTipoDocumentoLegal+4 as i_tipos_atos,
cast(cdTipoDocumentoLegal as text) + ' - ' + DsTipoDocumentoLegal as nome,
2 as classif, 
'S' as gera_tc , 
cdTipoDocumentoLegal as codigo_docto_tce,
22 as codigo_assunto_tce,
cdTipoDocumentoLegal as codigo_tce 
 from tecbth_delivery.gp001_TipoDocumentoLegal 
where CdTipoDocumentoLegal != 0;  
commit
; 
