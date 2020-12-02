//if point_in_rectangle(mouse_x,mouse_y,bbox_left,bbox_top,bbox_right,bbox_bottom) and input.mouseLeftPress { 
//	die()
//}

if !onGround applyThrust()

if !place_meeting(x,y,block) and onGround onGround = false

switch(state) {
	
	#region IDLE
		case state.idle:
		
			sprite_index = s_zombie_idle
			
			if timer > 0 timer--
			else if timer == 0 {
				timer = -1
				
				//	Lets idlewalk
				state = state.walk
				var dist = irandom_range(25,75)
				goalX = x + choose(-dist,dist)
				goalX = clamp(goalX,0,room_width)
				
			}
			
		break
	#endregion
	
	#region WALK
		case state.walk:
			
			if abs(goalX - x) > 5 {
				hspd += sign(goalX - x) * 0.05
				hspd = clamp(hspd,-maxSpeed,maxSpeed)
				x += hspd
				image_xscale = sign(hspd)
				sprite_index = s_zombie_walk
			}
			else {
				if hspd != 0 {
					if hspd > 0 hspd -= min(0.1,abs(hspd))
					if hspd < 0 hspd += min(0.1,abs(hspd))
				}
				else {
					state = state.idle
					goalX = -1
					timer = irandom_range(90,180)
				}
			}
			
		break
	#endregion
}