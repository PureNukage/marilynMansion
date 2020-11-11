if roomChangeStage > -1 {
	
	//draw_text(player.x,player.y,"CHANGING ROOM")
	
	//draw_set_color(c_black)
	//draw_rectangle(0,0,room_width,room_height,false)
	
	if roomChangeStage >= 1 {
		var surface = surface_create(room_width,room_height)
		surface_set_target(surface)
		draw_clear_alpha(c_black, 0)
		surface_reset_target()
		buffer_set_surface(roomChangeBuffer2, surface, 0,0,0)
		
		//var sizeRatio = 0 + (roomTime / roomDuration)
		var sizeAlpha = (roomTime / roomDuration)
		
		//if sizeAlpha < 0.5 sizeAlpha = 0
	
		//draw_surface_ext(surface,0,0, 1,1, 0,c_white, sizeAlpha)
		//draw_surface(surface,player.x,player.y)
	
		surface_free(surface)	
	}

	if roomChangeStage >= 0 {
		var surface = surface_create(room_width,room_height)
		surface_set_target(surface)
		draw_clear_alpha(c_black, 0)
		surface_reset_target()
		
		buffer_set_surface(roomChangeBuffer1, surface, 0,0,0)
	
		//var sizeRatio = 1 + (roomTime / roomDuration)
		var sizeAlpha = 1 - (roomTime / roomDuration)
		
		//if sizeAlpha < 0.5 sizeAlpha = 0
	
		//draw_surface_ext(surface,0,0, 1,1, 0,c_white, sizeAlpha)
		//draw_surface(surface,player.x,player.y)
	
		surface_free(surface)
	}
	
}