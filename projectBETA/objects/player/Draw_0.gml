switch(states)
{
	#region Free
		case states.free: 

			draw_self()

			if abs(hspd) > 0 {
				image_xscale = sign(hspd)
	
				image_speed = abs(hspd)/maxSpeed
	
				if !flashlight sprite_index = s_player_walk
				else sprite_index = s_player_walk_nogun
			} 

			else {
				if !flashlight sprite_index = s_player_idle	
				else sprite_index = s_player_idle_nogun
			}
		
		break
	#endregion
	
	#region Aim
		case states.aim:
		
			if mouse_x > x image_xscale = 1 else image_xscale = -1
		
			if arm1 > -1 draw_sprite_ext(arm1,0,x + (arm1_offsetX*image_xscale), y + arm1_offsetY, image_xscale,1,gunRotation+gunRotation,c_white,1)
		
			draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,1,0,c_white,1)
			
			if arm0 > -1 draw_sprite_ext(arm0,0,x + (arm0_offsetX*image_xscale), y + arm0_offsetY, 1, image_xscale,gunRotation,c_white,1)	
			
			window_set_cursor(cr_none)
			
			draw_set_color(c_black)
			draw_circle(mouse_x,mouse_y,reticle.radius,true)	
			
			reticle.aimIncreasing()
		
		break	
	#endregion
}

if bulletArcDraw > 0 {
	bulletArcDraw--
	draw_set_color(c_yellow)
	var XX = x + (-15*image_xscale)
	var YY = y - 34
	var Direction = point_direction(bulletArray[2],bulletArray[3], bulletArray[0],bulletArray[1])
	XX += lengthdir_x(64, Direction)
	YY += lengthdir_y(64, Direction)
	if debug.on draw_line(XX,YY, bulletArray[0],bulletArray[1])
} else {
	bulletArcDraw = -1	
}

//reticle.firstCalculate()