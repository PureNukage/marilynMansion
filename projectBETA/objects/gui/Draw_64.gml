if instance_exists(player) and game.states == states.looting {
	var xx = display_get_gui_width()/2
	var yy = 45
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_text_outlined(xx,yy,game.lootingString,c_white,c_black)
	
	draw_reset()
}

////	WEAPON
if instance_exists(player) {
	draw_set_halign(fa_right)
	var xx = game.width - 15
	var yy = 15
	
	var e = []
	e[item.hand] = "hand"
	e[item.gun] = "gun"
	e[item.flashlight] = "flashlight"
	
	draw_text_outlined(xx,yy,e[player.inventory[player.inventoryIndex].item],c_white,c_black) yy += 15
	
	if player.inventory[player.inventoryIndex].item = item.gun {
		draw_text_outlined(xx,yy,string(player.ammo)+"/"+string(player.ammoMax),c_white,c_black)	
	}
	
	draw_reset()
}