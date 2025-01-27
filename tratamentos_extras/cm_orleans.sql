UPDATE BETHADBA.movimentos m 
left join bethadba.HIST_EVENTOS e 
on m.i_eventos = e.i_eventos
set m.tipo_pd = e.tipo_pd , m.compoe_liq = e.compoe_liq 