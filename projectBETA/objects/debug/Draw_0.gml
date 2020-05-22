if on {
	
	draw_set_color(c_yellow)
	
	if instance_exists(player) with player {
		
		var xx = x+64
		var yy = y-64
		
		var array = []
		array[states.free] = "free"
		array[states.aim] = "aim"
		
		draw_text(xx,yy, "state: " + array[states])	yy += 15
		draw_text(xx,yy, "hspd: " + string(hspd))	yy += 15
		draw_text(xx,yy, "gunRotation: "+string(gunRotation))	yy += 15
		
		
		
		
	}
	
	
	
	
}