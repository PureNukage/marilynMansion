if instance_exists(player) and game.states == states.looting {
	var xx = display_get_gui_width()/2
	var yy = 45
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_text_outlined(xx,yy,game.lootingString,c_white,c_black)
	
	draw_reset()
}