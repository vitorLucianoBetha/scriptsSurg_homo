


begin
	// *****  Tabela bethadba.vinculos
	declare w_i_vinculos smallint;
	declare w_i_motivos_resc smallint;
	declare w_i_adicionais integer;
	declare w_categoria_esocial integer;
	declare w_categoria_sefip tinyint;
	declare w_tipo_vinculo char(1);
	
	ooLoop: for oo as cnv_vinculos dynamic scroll cursor for
		select 1 as w_i_entidades,CdVinculoEmpregaticio as w_CdVinculoEmpregaticio,DsVinculoEmpregaticio as w_descricao,'0'||cdDirf as w_natureza_rendim,cdCategoriaTrabalhador as w_cdCategoriaTrabalhador,
		       coalesce(CdVinculoRais,10) as w_codigo_rais,tpRegimeContrato as w_tpRegimeContrato ,null as w_categoriaesocial
		from tecbth_delivery.gp001_vinculoempregaticio
	do
		// *****  Inicializa Variaveis
		set w_i_vinculos=null;
		set w_i_motivos_resc=null;
		set w_i_adicionais=null;
		set w_categoria_sefip=null;
		set w_tipo_vinculo=null;
		--BTHSC-8004 Não migrou informação Sai na RAIS e código da RAIS para todos os vínculos
       set w_codigo_rais = null;
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
		/*// *****  Converte tabela bethadba.vinculos  
		if w_CdVinculoEmpregaticio in(1,10) then --Celetista
			set w_i_vinculos=1
		elseif w_CdVinculoEmpregaticio in(2) then --Estatutário
			set w_i_vinculos=15
		elseif w_CdVinculoEmpregaticio in(3) then --Estagiário
			set w_i_vinculos=16
		elseif w_CdVinculoEmpregaticio in(4) then --Comissionado
			set w_i_vinculos=13
		elseif w_CdVinculoEmpregaticio in(5) then --Outros
			set w_i_vinculos=2		
        elseif w_CdVinculoEmpregaticio in(6) then --Outros
			set w_i_vinculos=12	 		
        elseif w_CdVinculoEmpregaticio in(7) then --Outros
			set w_i_vinculos=17	 			
        elseif w_CdVinculoEmpregaticio in(8) then --Outros
			set w_i_vinculos=1	 			
        elseif w_CdVinculoEmpregaticio in(9) then --Outros
			set w_i_vinculos=2	 			
        elseif w_CdVinculoEmpregaticio in(11) then --Outros
			set w_i_vinculos=8	 			
        elseif w_CdVinculoEmpregaticio in(12) then --Outros
			set w_i_vinculos=18	 
        elseif w_CdVinculoEmpregaticio in(13) then --Outros
			set w_i_vinculos=19
        elseif w_CdVinculoEmpregaticio in(14) then --Outros
			set w_i_vinculos=20			
		end if;
		*/
		
		if w_i_vinculos is null then
			select coalesce(max(i_vinculos),0)+1 
			into w_i_vinculos 
			from bethadba.vinculos;
		end if; 
		
		set w_i_motivos_resc=null;
		set w_i_adicionais=null;
		
		if w_cdCategoriaTrabalhador in(0,1,11,2) then
			set w_categoria_sefip=1
		else
			set w_categoria_sefip=1
		end if;
				
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
										  gera_licpremio,tipo_func,categoria_esocial)on existing skip
			values (w_i_vinculos,w_i_motivos_resc,w_i_adicionais,w_descricao,w_natureza_rendim,'N',w_categoria_sefip,'N',w_codigo_rais,'N',w_tipo_vinculo,
				   'N','F',w_categoriaesocial); 
			
			insert into tecbth_delivery.antes_depois 
			values('V',w_i_entidades,w_CdVinculoEmpregaticio,null,null,w_i_vinculos,null,null,null,null); 
		else
			message 'Vin.: '||string(w_i_vinculos)||' Des.: '||string(w_descricao) to client;
			
			insert into tecbth_delivery.antes_depois 
			values('V',w_i_entidades,w_CdVinculoEmpregaticio,null,null,w_i_vinculos,null,null,null,null);
		end if;
	end for;
end
