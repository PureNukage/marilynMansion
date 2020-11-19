if player.inventory[player.inventoryIndex].item != item.gun {
	var ID = instance_position(mouse_x,mouse_y,class_grab)
	var Scale = 0.5
	if ID > -1 {
		cursor = s_hand
	} else {
		cursor = s_hand_open
	}
	draw_sprite_ext(cursor,0,mouse_x,mouse_y,Scale,Scale,0,c_white,1)	
}