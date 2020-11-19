switch(states)
{	
	#region Free 
		case states.free:
			if input.keyRight or input.keyLeft {
				hspd += input.keyRight - input.keyLeft
	
				hspd = clamp(hspd,-maxSpeed,maxSpeed)
	
				xx += hspd
			}

			else if !game.lootingMoving {
	
				if abs(hspd) != 0 {
					hspd = lerp(hspd,0,0.1)
		
					if abs(hspd) - maxSpeed < 0.5 hspd = 0
		
					xx += hspd		
				}
	
			}
				
			//	Sprite determination
			if hspd != 0 {
				var old_xscale = image_xscale
				image_xscale = sign(hspd)
				image_speed = abs(hspd)/maxSpeed
				switch(inventory[inventoryIndex].item) {
					case item.hand: sprite_index = s_player_walk_nogun break
					case item.gun: sprite_index = s_player_walk break
					case item.flashlight: sprite_index = s_player_flashlight_walk break
				}
				if old_xscale != image_xscale {
					var X = (x + (arm0_offsetX*old_xscale)) + lengthdir_x(50, gunRotation)
					var Y = y+arm0_offsetY + lengthdir_y(50, gunRotation)
					var newWidth = abs(X - (x + (arm0_offsetX*old_xscale)))
					var newX = (x + (arm0_offsetX*image_xscale)) + (image_xscale * newWidth)
					gunRotation = point_direction((x + (arm0_offsetX*image_xscale)),y+arm0_offsetY, newX,Y)
				}
			}
			else {
				switch(inventory[inventoryIndex].item) {
					case item.hand: sprite_index = s_player_idle_nogun break
					case item.gun: sprite_index = s_player_idle break
					case item.flashlight: sprite_index = s_player_flashlight break
				}
			}
				
			//	Aiming
			if input.mouseRightPress {
				states = states.aim	
				reticle.firstCalculate()
				switch(inventory[inventoryIndex].item) {
					case item.hand:
						sprite_index = s_player_idle_nogun
					break
					case item.gun:
						sprite_index = s_player_body
					break
					case item.flashlight:
						sprite_index = s_player_flashlight
					break
				}
			}
			else {
				reticle.radiusSpeed = 0.5	
			}
			
			//	Flashlight
			if input.keyFlashlight and inventory[inventoryIndex].item == item.flashlight {
				flashlightOn = !flashlightOn
				game.Player.flashlightOn = flashlightOn
				sound.playSoundEffect(snd_click)
			}
			
			//	Looting
			if game.lootingMoving lootMoving()
			
			//	Change hand slots
			if input.keyLeftHand change_inventory(0)
			else if input.keyRightHand change_inventory(1)
			else if input.keyBothHand change_inventory(2)
			
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
			
			gunRotation = point_direction(x+arm0_offsetX,y+arm0_offsetY, mouse_x,mouse_y)
			
			//	Stop aiming
			if input.mouseRightRelease {
				states = states.free
				window_set_cursor(cr_default)
			}
			
			switch(inventory[inventoryIndex].item) {
				case item.hand:
				
				break
				case item.gun:
					if arm0 == s_player_arm_aim_fire arm0 = s_player_arm_aim	
				break
				case item.flashlight:
					if input.keyRight or input.keyLeft {
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
					
					else {
	
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
				break
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
			
			//	Use item in hand
			if input.mouseLeftPress {
				if inventory[inventoryIndex].item == item.gun {
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
				else if inventory[inventoryIndex].item == item.flashlight {
					//flashlightOn = !flashlightOn
				}
			}
			
		break
	#endregion

}

if !place_meeting(x,y-32,block) onGround = false

if !onGround applyThrust()