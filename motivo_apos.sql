      CALL bethadba.dbp_conn_gera(1, 2019, 300);
CALL bethadba.pg_setoption('wait_for_commit', 'on');
CALL bethadba.pg_habilitartriggers('off');
COMMIT;
            insert into bethadba.motivos_apos 
        select 
		cdDesligamento as i_motivos_apos,
		null as i_tipo_movpes,
		dsDesligamento as descricao,
		cast(cdRais as varchar(10)) as motivo_rais,
		cast(cdCaged as varchar(10)) as motivo_gifp,
		'N' as mantem_vinc,
		case cdDesligamento 
		when 16 then 2
		when 17 then 1
		when 18 then 3
		when 19 then 4
		else 1 
		end as tipo_apos,
		19 as i_tipos_afast,
		null as i_tipos_mov_resc,
		null as categoria_esocial
		from tecbth_delivery.gp001_tipodesligamento
		where cdDesligamento in (16,17,18,19,20,21,22)


		UPDATE BETHADBA.motivos_apos set i_tipos_afast = 9
		update bethadba.motivos_apos set categoria_esocial = '38'