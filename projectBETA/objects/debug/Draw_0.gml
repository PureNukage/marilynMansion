if on {
	
	var array = []
	array[states.free] = "free"
	array[states.aim] = "aim"
	
	draw_set_color(c_yellow)
	
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
		
		draw_text(xx,yy, "physics: " + string(phy_active))
		
		//draw_text(xx,yy, "image_xscale: " + string(image_xscale))
		
	}
	
	draw_set_color(c_red)
	with block {
		physics_draw_debug()
	}
	
	
	
	
}