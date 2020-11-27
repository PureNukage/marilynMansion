if on { 

	var xx = 5
	var yy = 5

	draw_set_color(c_black)
	draw_text_outlined(xx,yy, "DEBUG", c_white,c_black)
	
	var boolean = []
	boolean[0] = "false"
	boolean[1] = "true"
	
	if selectedBodypart > -1 {
		yy += 45
		var Object = object_get_name(selectedBodypart.ragdoll.unit_index)
		draw_text(xx,yy, Object)
		yy += 15
		var Sprite = sprite_get_name(selectedBodypart.sprite_index)
		var copyLength = 3 + string_length(Object) + 1
		var text = string_copy(Sprite,copyLength,string_length(Sprite))
		draw_text(xx,yy, text)
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
	
	//	Physics fixtures
	yy += 25
	var _phy_fix_on = button(xx,yy,130,20,"phy fix: "+boolean[phy_fix_on])
	if _phy_fix_on and input.mouseLeftPress {
		phy_fix_on = !phy_fix_on	
	}
	
	draw_reset()
	
}