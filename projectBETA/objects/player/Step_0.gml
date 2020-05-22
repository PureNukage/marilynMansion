switch(states)
{	
	#region Free 
		case states.free:
			if input.keyRight or input.keyLeft {
				hspd += input.keyRight - input.keyLeft
	
				hspd = clamp(hspd,-maxSpeed,maxSpeed)
	
				xx += hspd
			}

			else {
	
				if abs(hspd) != 0 {
					hspd = lerp(hspd,0,0.1)
		
					if abs(hspd) - maxSpeed < 0.5 hspd = 0
		
					xx += hspd		
				}
	
			}
				
			//	Aiming
			if input.mouseRightPress {
				states = states.aim	
			}
			
			////	Collision Checking
			if xx != 0 {
	
				for(var XX=0;XX<abs(xx);XX++) {
					if !instance_place(x + sign(xx), y, block) x += sign(xx)
					else {
			
					}
				}
				xx = 0
	
			}
		
		break
	#endregion
	
	#region Aim
		case states.aim:
			
			gunRotation = point_direction(x,y, mouse_x,mouse_y)
			
			if input.mouseRightRelease {
				states = states.free
			}
			
			
			
		break
	#endregion
}