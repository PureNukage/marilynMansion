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
			
			//	Stop aiming
			if input.mouseRightRelease {
				states = states.free
			}
			
			//	Shoot gun
			if input.mouseLeftPress {
				var array = fireGun()
				if is_array(array) {
					array[0].die()
					////	Check for if a bodypart is at the bullets x,y
					for(var b=0;b<array_length(array[0].bodyparts);b++) {
						var XX = array[1]
						var YY = array[2]
						var ID = array[0].bodyparts[b][bodyparts_id]
						
						var e = []
						e[bodyParts.torso] = "torso"
						e[bodyParts.head] = "head"
						e[bodyParts.rightArmUpper] = "rightArmUpper"
						e[bodyParts.rightArmLower] = "rightArmLower"
						e[bodyParts.rightArmHand] = "rightArmHand"
						e[bodyParts.leftArmUpper] = "leftArmUpper"
						e[bodyParts.leftArmLower] = "leftArmLower"
						e[bodyParts.leftArmHand] = "leftArmHand"
						e[bodyParts.rightLegUpper] = "rightLegUpper"
						e[bodyParts.rightLegLower] = "rightLegLower"
						e[bodyParts.leftLegUpper] = "leftLegUpper"
						e[bodyParts.leftLegLower] = "leftLegLower"
						 
						if instance_position(XX, YY, ID) {
							show_debug_message("applying force to object: "+e[array[0].bodyparts[b][bodyparts_enum]])
							with ID physics_apply_force(XX,YY, 50000,0)
						}
					}
					
					
					show_debug_message("hit object "+object_get_name(array[0].object_index))
					show_debug_message(string(array[1]))
					show_debug_message(string(array[2]))
				}
			}
			
			
			
		break
	#endregion
}