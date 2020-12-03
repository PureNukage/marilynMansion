switch(states) {
	case states.free:
	
		sprite_index = zombie_idle
	
		//	Idle
		if timer > -1 timer-- 
		else {
			states = states.walk
			var dist = 100
			goalX = irandom_range(x-dist,x+dist)
			goalX = clamp(goalX,0,room_width)
		}
		
	break
	case states.walk:
		
		//	Move towards goal
		if abs(x - goalX) > 5 { 
			hspd += sign(goalX - x) * .05
			hspd = clamp(hspd,-maxSpeed,maxSpeed)
			
			image_xscale = sign(goalX - x)
			sprite_index = zombie_walk
			
			//	Slow speed after each foot step
			if floor(image_index) == 1 or floor(image_index) == 5 {
				if hspd > 0 hspd -= min(0.1,abs(hspd))
				if hspd < 0 hspd += min(0.1,abs(hspd)) 
			}
			
			x += hspd
		}
		else {
			if hspd != 0 {
				if hspd > 0 hspd -= min(0.1,abs(hspd))
				if hspd < 0 hspd += min(0.1,abs(hspd))
			}
			else {
				states = states.free
				timer = irandom_range(90,180)
				goalX = -1
			}
		}
		
	break
}

//image_xscale = -1

if !place_meeting(x,y-32,block) onGround = false

if !onGround applyThrust()