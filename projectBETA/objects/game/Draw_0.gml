if (player.inventory[player.inventoryIndex].item != item.gun or player.states == states.free or player.states == states.reloading) {
	var ID = instance_position(mouse_x,mouse_y,class_grab)
	var Scale = 0.75
	if ID > -1 {
		cursor = s_hand
	} else {
		cursor = s_hand_open
	}
	draw_sprite_ext(cursor,0,mouse_x,mouse_y,Scale,Scale,0,c_white,1)	
}
else if player.inventory[player.inventoryIndex].item == item.gun {
	draw_set_color(c_black)
	draw_circle(mouse_x,mouse_y,player.reticle.radius,true)	
	player.reticle.aim_calculate()	
}