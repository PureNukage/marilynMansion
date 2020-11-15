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
				reticle.firstCalculate()
			}
			else {
				reticle.radiusSpeed = 0.5	
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
				
			arm0 = s_player_arm_aim
			
			//	Shoot gun
			if input.mouseLeftPress {
				var array = fireGun()
				arm0 = s_player_arm_aim_fire
				reticle.radius += 32
				
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
				
				if is_array(array) {
					if array[0].object_index == zombie {
						
						array[0].hp -= 1
						
						if array[0].hp <= 0 {
							array[0].die()	
						}
						
						////	Check for if a bodypart is at the bullets x,y
						for(var b=0;b<array_length(array[0].bodyparts);b++) {
							var XX = array[1]
							var YY = array[2]
							var ID = array[0].bodyparts[b][bodyparts_id]
						 
							if instance_position(XX, YY, ID) {
								show_debug_message("applying force to object: "+e[array[0].bodyparts[b][bodyparts_enum]])
								var Direction = sign(ID.x - x)
								var randomForce = irandom_range(45000,55000)  * Direction
								with ID physics_apply_force(XX,YY, randomForce,0)
							
								var Decal = instance_create_layer(XX,YY, "Instances",decal)
								Decal.sprite_index = s_bloodhole_0
								Decal.ID = ID
								
								//	DEBUG
								var Decal = instance_create_layer(XX,YY, "Instances",particle)
								Decal.sprite_index = s_debug_decal
								Decal.depth = -200
							}
						}
					}
					//	A body part
					else {
						var XX = array[1]
						var YY = array[2]
						var ID = array[0]
						show_debug_message("applying force to object: " + e[array[0].bodyParts])
						var Direction = sign(ID.x - x)
						var randomForce = irandom_range(45000,55000) * Direction
						with ID physics_apply_force(XX,YY, randomForce,0)
							
						var Decal = instance_create_layer(XX,YY, "Instances",decal)
						Decal.sprite_index = s_bloodhole_0
						Decal.ID = ID
						
						//	DEBUG
						var Decal = instance_create_layer(XX,YY, "Instances",particle)
						Decal.sprite_index = s_debug_decal
						Decal.depth = -200
					}
					
					show_debug_message("hit object "+object_get_name(array[0].object_index))
					show_debug_message(string(array[1]))
					show_debug_message(string(array[2]))
				}
			}
			
			
			
		break
	#endregion
}

if !place_meeting(x,y-32,block) onGround = false

if !onGround applyThrust()