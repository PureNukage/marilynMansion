draw_self()

if states == states.aim and arm > -1 {
	
	var rotation = point_direction(x,y-20,mouse_x,mouse_y)
	if mouse_x < x var yscale = -1 else var yscale = 1
	draw_sprite_ext(arm,0,x-11,y-23,1,yscale,rotation,c_white,1)
	if image_xscale != yscale image_xscale = yscale
	
	//	Facing the right
	if image_xscale > 0 { 
		if rotation > 45 and rotation < 91 {
			arm = s_player_aim_arm2	
		}
		else if rotation > 269 and rotation < 305 {
			arm = s_player_aim_arm1
		} else {
			arm = s_player_aim_arm	
		}
	} 
	//	Facing the left
	else {
		
	}	
	
	
}