if on { 

	var xx = 5
	var yy = 5

	draw_set_color(c_black)
	draw_text_outlined(xx,yy, "DEBUG", c_white,c_black)
	
	var boolean = []
	boolean[0] = "false"
	boolean[1] = "true"
	
	if selectedBodypart > -1 {
		yy += 15
		draw_text(xx,yy, object_get_name(selectedBodypart.ragdoll.unit_index))	
	}
	
	
	////	DEBUG GUI
	//	Restart button
	var xx = xx + 60
	var yy = 5
	var restart = button(xx,yy,80,20,"restart")
	if restart and input.mouseLeftPress {
		room_restart()
		selectedBodypart = -1	
	}
	
	//	Physics pause
	var xx = app.width-135
	var yy = 5
	var _physics_on = button(xx,yy,130,20,"physics: "+boolean[physics_on])
	if _physics_on and input.mouseLeftPress {
		physics_on = !physics_on	
		physics_pause_enable(!physics_on)
	}
	
	draw_reset()
	
}