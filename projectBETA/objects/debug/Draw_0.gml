if on {
	
	var array = []
	array[states.free] = "free"
	array[states.aim] = "aim"
	
	draw_set_color(c_yellow)
	
	var gameScale = 0.1
	if instance_exists(game) draw_sprite_ext(s_debug_camera,0,game.x,game.y,gameScale,gameScale,0,c_white,1)
	
	if instance_exists(zombie) with zombie {
		draw_set_color(c_yellow)
		var x1 = x-sprite_get_xoffset(sprite_index)
		var y1 = y-sprite_get_yoffset(sprite_index)
		draw_rectangle(x1,y1, x1+sprite_get_width(sprite_index),y1+sprite_get_height(sprite_index),true)
	}
	
	if instance_exists(player) with player {
		
		var xx = x+64
		var yy = y-64
		
		
		//draw_text(xx,yy, "state: " + array[states])	yy += 15
		//draw_text(xx,yy, "hspd: " + string(hspd))	yy += 15
		//draw_text(xx,yy, "gunRotation: "+string(gunRotation))	yy += 15
		
		
		
		
	}
	
	if instance_exists(zombieRagdoll) with zombieRagdoll {
		
		var xx = x+64
		var yy = y-64
		
		//draw_text(xx,yy, "physics: " + string(phy_active))
		
		//draw_text(xx,yy, "image_xscale: " + string(image_xscale))
		
	}
	
	draw_set_color(c_red)
	with block {
		physics_draw_debug()
	}
	
	
	
	
}