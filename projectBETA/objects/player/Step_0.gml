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
				if !flashlight {
					sprite_index = s_player_body
				}
			}
			else {
				reticle.radiusSpeed = 0.5	
			}
			
			//	Looting
			if input.keyLoot {
				states = states.looting
				game.states = states.looting
				lootingClampX1 = camera_get_view_x(game.camera)
				lootingClampX2 = camera_get_view_x(game.camera) + camera_get_view_width(game.camera)
				lootingClampY1 = camera_get_view_y(game.camera)
				lootingClampY2 = camera_get_view_y(game.camera) + camera_get_view_height(game.camera)
				game.zoom_level = .7
			}
			
			//	Flashlight
			if input.keyFlashlight and !flashlight{
				flashlight = true
			}
			else if input.keyFlashlight and flashlight {
				flashlight = false	
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
			
			if flashlight and (input.keyRight or input.keyLeft) {
				hspd += input.keyRight - input.keyLeft
				
				var flashlightClamp = 0
				if (image_xscale and hspd < 0) or (image_xscale == -1 and hspd > 0) {
					flashlightClamp = maxSpeed
				}
	
				hspd = clamp(hspd,-(maxSpeed-flashlightClamp),maxSpeed-flashlightClamp)
	
				xx += hspd
				
				if hspd != 0 sprite_index = s_player_flashlight_walk
				else sprite_index = s_player_flashlight
			}
				
			else if flashlight {
	
				if abs(hspd) != 0 {
					hspd = lerp(hspd,0,0.1)
		
					if abs(hspd) - maxSpeed < 0.5 hspd = 0
		
					xx += hspd		
					
					sprite_index = s_player_flashlight_walk
				}
				else {
					sprite_index = s_player_flashlight	
				}
	
			}
				
			if !flashlight {
				arm0 = s_player_arm_aim
				arm1 = s_player_arm_support
			} else {
				arm0 = s_player_arm_flashlight
				arm1 = -1
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
			
			//	Shoot gun
			if !flashlight and input.mouseLeftPress {
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
								var Direction = point_direction(player.x + (-15 * player.image_xscale),player.y-34, XX,YY)

								var xForce = lengthdir_x(irandom_range(50000,100000), Direction)
								var yForce = lengthdir_y(irandom_range(50000,100000), Direction)
								with ID physics_apply_force(XX,YY, xForce,yForce)
							
								var Decal = instance_create_layer(XX,YY, "Instances",decal)
								Decal.sprite_index = s_bloodhole_0
								Decal.ID = ID
								
								//	DEBUG
								//var Decal = instance_create_layer(XX,YY, "Instances",particle)
								//Decal.sprite_index = s_debug_decal
								//Decal.depth = -200
							}
						}
					}
					//	A body part
					else {
						var XX = array[1]
						var YY = array[2]
						var ID = array[0]
						show_debug_message("applying force to object: " + e[array[0].bodyParts])
						var Direction = point_direction(player.x + (-15 * player.image_xscale),player.y-34, XX,YY)

						var xForce = lengthdir_x(irandom_range(50000,100000), Direction)
						var yForce = lengthdir_y(irandom_range(50000,100000), Direction)
						with ID physics_apply_force(XX,YY, xForce,yForce)
							
						var Decal = instance_create_layer(XX,YY, "Instances",decal)
						Decal.sprite_index = s_bloodhole_0
						Decal.ID = ID
						
						//	DEBUG
						//var Decal = instance_create_layer(XX,YY, "Instances",particle)
						//Decal.sprite_index = s_debug_decal
						//Decal.depth = -200
					}
					
					show_debug_message("hit object "+object_get_name(array[0].object_index))
					show_debug_message(string(array[1]))
					show_debug_message(string(array[2]))
				}
			}
			
			
			
		break
	#endregion
	
	#region Looting
		case states.looting:
		
			//cursor_sprite = s_hand
			
			//	Stop looting
			if input.keyLoot {
				states = states.free
				game.states = states.free
				lootingClampX1 = -1
				lootingClampX2 = -1
				lootingClampY1 = -1
				lootingClampY2 = -1
				lootingID = -1
				lootingMoving = false
				game.zoom_level = 1
			}
			
			var ID = instance_position(mouse_x,mouse_y,class_grab)
			
			if ID > -1 {
				window_set_cursor(cr_none)
				//cursor_sprite = s_hand
				lootingString = object_get_name(ID.object_index)
				
				if input.mouseLeftPress and ID.object_index == candle and lootingID == -1 {
					//ID.interact(!ID.on)
					lootingID = ID
					lootingMoving = true
				}
			}
			else {
				window_set_cursor(cr_arrow)
				cursor_sprite = -1
				lootingString = ""	
			}
				
			//	Moving to goal
			if lootingMoving {
				
				//	Arrived at goal
				if point_distance(x,y, lootingID.x,lootingID.y) < 20 {
					lootingMoving = false
					
					if lootingID.object_index == candle
					lootingID.interact(!lootingID.on)
					
					lootingID = -1
				}
				//	Moving to goal
				else {
				
					hspd += sign(lootingID.x - x)
				
					hspd = clamp(hspd,-maxSpeed,maxSpeed)
	
					xx += hspd
				}
			}
			else {
				if abs(hspd) != 0 {
					hspd = lerp(hspd,0,0.1)
		
					if abs(hspd) - maxSpeed < 0.5 hspd = 0
		
					xx += hspd		
				}
			}
			
			//	Determine sprite
			if hspd != 0 {
				if hspd > 0 image_xscale = 1
				else image_xscale = -1
				
				if flashlight sprite_index = s_player_walk_nogun
				else sprite_index = s_player_walk
			}
			else {
				if flashlight sprite_index = s_player_idle_nogun
				else sprite_index = s_player_idle
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
}

if !place_meeting(x,y-32,block) onGround = false

if !onGround applyThrust()