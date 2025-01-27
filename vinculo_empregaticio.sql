


begin
	// *****  Tabela bethadba.vinculos
	declare w_i_motivos_resc smallint;
	declare w_i_adicionais integer;
	declare w_categoria_esocial integer;
	declare w_tipo_vinculo char(1);
	
	ooLoop: for oo as cnv_vinculos dynamic scroll cursor for
		select 1 as w_i_entidades,
			CdVinculoEmpregaticio as w_i_vinculos,
			DsVinculoEmpregaticio as w_descricao,
			'0'||cdDirf as w_natureza_rendim,
			w_categoria_sefip = case cdCategoriaTrabalhador when 1 then 1
				when 3 then 3
				when 4 then 4
				when 7 then 7
				when 12 then 12
				when 19 then 19
				when 20 then 20
				when 21 then 21
			else 1 end,
		    coalesce(CdVinculoRais,10) as w_codigo_rais,
		    tpRegimeContrato as w_tpRegimeContrato,
		    w_categoriaesocial = case et.CD_CATEGORIA_TRABALHADOR when 721 then 741
		    	when 722 then 741
		    	when 723 then 741
		    	when 751 then 741
		    else isnull(et.CD_CATEGORIA_TRABALHADOR,101) end,
		    gtv.CD_TIPO_ATIVO_SIAP as w_codigo_tce
		from tecbth_delivery.gp001_vinculoempregaticio vp
		left join tecbth_delivery.gp001_eSocial_Categoria_Trabalhador et on vp.cdCategoriaTrabalhador_eSocial = et.PKID
		left join tecbth_delivery.gp001_TCSC_VINCULO_EMPREGATICIO gtv on gtv.CD_VINCULO_EMPREGATICIO = vp.CdVinculoEmpregaticio
	do
		// *****  Inicializa Variaveis
		set w_i_motivos_resc=null;
		set w_i_adicionais=null;
		set w_tipo_vinculo=null;
	   --BUG BTHSC-8002 Não migrou categoria do trabalhador corretamente.
	set w_categoria_esocial=(	CASE
 
WHEN w_descricao = 'INATIVOS PAGOS RECURSO TESOURO'THEN  701
 WHEN w_descricao = 'INATIVOS PAGOS RECURSO PREVID 'THEN  701
 WHEN w_descricao = 'PENSIONISTAS - RECURSO PROPRIO'THEN  701
 WHEN w_descricao = 'BENEFICIARIAS (PENSAO JUDICIAL'THEN  309
 WHEN w_descricao = 'JOVEM APRENDIZ                'THEN  701
 WHEN w_descricao = 'ESTAGIARIO                    'THEN  901
 WHEN w_descricao = 'BOLSISTAS                     'THEN  903
 WHEN w_descricao = 'CONSELHO TUTELAR              'THEN  701
 WHEN w_descricao = 'CONTRATO CLT INDETERMINADO    'THEN  701
 WHEN w_descricao = 'AUTONOMOS                     'THEN  701
 WHEN w_descricao = 'CARGO EFETIVO - VINCULO RGPS  'THEN  701
 WHEN w_descricao = 'FUNCAO DE CONFIANCA           'THEN  701
 WHEN w_descricao = 'SECRETARIO REC. RESTRITO      'THEN  701
 WHEN w_descricao = 'CARGO COMISSAO - REC INTERNO  'THEN  701
 WHEN w_descricao = 'SERVIDOR CEDIDO               'THEN  410
 WHEN w_descricao = 'BENEFICIO PREVIDENCIARIO      'THEN  701
 WHEN w_descricao = 'PENSIONISTAS - RECURSO PREVID 'THEN  701
 WHEN w_descricao = 'EMPREGO PUBLICO               'THEN  701
 WHEN w_descricao = 'CONTRIB IND -AUTONOMO EM GERAL'THEN  701
 WHEN w_descricao = 'TRANSP AUTONOMO DE PASSAGEIRO 'THEN  701
 WHEN w_descricao = 'TRANSP AUTONOMO DE CARGA      'THEN  701
 WHEN w_descricao = 'MEDICO RESIDENTE              'THEN  902
 WHEN w_descricao = 'CONTRATO PRAZO INDETERMINADO  'THEN  111
 WHEN w_descricao = 'SENTENCA JUDICIAL             'THEN  701
 WHEN w_descricao = 'CONSELHEIRO JETON             'THEN  305
 WHEN w_descricao = 'READMISSAO JUDICIAL           'THEN  701
    ELSE null
END);		
		
		set w_i_motivos_resc=null;
		set w_i_adicionais=null;
	
				
		if w_tpRegimeContrato = 'C' then
			set w_tipo_vinculo=1
		elseif w_tpRegimeContrato = 'E' then
			set w_tipo_vinculo=2
		end if;
		
		if w_codigo_rais = 0 then
			set w_codigo_rais = 10;
		end if;
		
		if not exists(select 1 from bethadba.vinculos where	trim(descricao) = trim(w_descricao) and	tipo_func = 'F') then
			message 'Vin.: '||string(w_i_vinculos)||' Des.: '||string(w_descricao) to client;
			insert into bethadba.vinculos(i_vinculos,i_motivos_resc,i_adicionais,descricao,natureza_rendim,sai_rais,categoria_sefip,sai_caged,codigo_rais,vinculo_temp,tipo_vinculo,
										  gera_licpremio,tipo_func,categoria_esocial, codigo_tce)on existing skip
			values (w_i_vinculos,w_i_motivos_resc,w_i_adicionais,w_descricao,w_natureza_rendim,'S',w_categoria_sefip,'N',w_codigo_rais,'N',w_tipo_vinculo,
				   'N','F',w_categoriaesocial, w_codigo_tce); 
			
			insert into tecbth_delivery.antes_depois 
			values('V',w_i_entidades,w_i_vinculos,null,null,w_i_vinculos,null,null,null,null); 
		else
			message 'Vin.: '||string(w_i_vinculos)||' Des.: '||string(w_descricao) to client;
			
			insert into tecbth_delivery.antes_depois 
			values('V',w_i_entidades,w_i_vinculos,null,null,w_i_vinculos,null,null,null,null);
		end if;
	end for;
end;
commit;
