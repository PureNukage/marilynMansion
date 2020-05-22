switch(states)
{
	#region Free
		case states.free: 

			draw_self()

			if abs(hspd) > 0 {
				image_xscale = sign(hspd)
	
				image_speed = abs(hspd)/maxSpeed
	
				sprite_index = s_player_walk
			} 

			else {
				sprite_index = s_player_idle	
			}
		
		break
	#endregion
	
	#region Aim
		case states.aim:
		
			if mouse_x > x image_xscale = 1 else image_xscale = -1
		
			draw_sprite_ext(arm1,0,x + (arm1_offsetX*image_xscale), y + arm1_offsetY, image_xscale,1,gunRotation+gunRotation,c_white,1)
		
			draw_sprite_ext(s_player_body,0,x,y,image_xscale,1,0,c_white,1)
			
			draw_sprite_ext(arm0,0,x + (arm0_offsetX*image_xscale), y + arm0_offsetY, 1, image_xscale,gunRotation,c_white,1)	
		
		break	
	#endregion
}
	