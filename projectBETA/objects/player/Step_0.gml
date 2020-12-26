switch(states)
{	
	#region Free 
		case states.free:
			if input.keyRight or input.keyLeft {
				
				if cooldown < 1 {
					sound.playSoundEffect(choose(Step1, Step2, Step3, Step4,Step5,Step6))
					cooldown = 25
				}
				
				cooldown = cooldown -1
				
				if game.lootingMoving {
					game.lootingMoving = false
					game.lootingID = -1
				}
				hspd += (input.keyRight - input.keyLeft) * 0.10
	
				hspd = clamp(hspd,-maxSpeed,maxSpeed)
	
				xx += hspd
				
				//	Stairs
				if (input.keyUp or input.keyDown) and place_meeting(x,y,stairs) {
					var Stairs = instance_place(x,y,stairs)
					if Floor == Stairs.bottomFloor {
						if x <= Stairs.leftX {
							onStairs = Stairs
							y -= 1
						}
					}
					else if Floor == Stairs.topFloor {
						if x >= Stairs.rightX-4 and x <= Stairs.rightX+8 {
							onStairs = Stairs
							y += 1
						}
					}
				}
				if onStairs {
					if (bbox_bottom <= onStairs.bbox_top) or (bbox_bottom >= onStairs.bbox_bottom) onStairs = false
				}
				
				
			}

			else if !game.lootingMoving {
				
				if hspd != 0 {
					if hspd > 0 hspd -= min(0.1,abs(hspd))
					if hspd < 0 hspd += min(0.1,abs(hspd))
				}
				xx += hspd
	
				//if abs(hspd) != 0 {
				//	hspd = lerp(hspd,0,0.1)
		
				//	if abs(hspd) - maxSpeed < 0.5 hspd = 0
		
				//	xx += hspd		
				//}
	
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
					var X = (x + (arm1_offsetX*old_xscale)) + lengthdir_x(50, gunRotation)
					var Y = y+arm1_offsetY + lengthdir_y(50, gunRotation)
					var newWidth = abs(X - (x + (arm1_offsetX*old_xscale)))
					var newX = (x + (arm1_offsetX*image_xscale)) + (image_xscale * newWidth)
					gunRotation = point_direction((x + (arm1_offsetX*image_xscale)),y+arm1_offsetY, newX,Y)
				}
			}
			else {
				switch(inventory[inventoryIndex].item) {
					case item.hand: sprite_index = s_player_idle_nogun break
					case item.gun: sprite_index = s_player_idle break
					case item.flashlight: sprite_index = s_player_flashlight break
				}
				image_speed = 1
			}
			

				
			//	Aiming
			if input.mouseRightPress {
				states = states.aim	
				reticle.first_calculate()
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
				//reticle.radiusSpeed = 0.5	
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
						//var ID = instance_place(x + sign(xx), y, block)
						//if ID.Floor > Floor x += sign(xx)
						if onStairs x += sign(xx)
					}
					if onStairs {
						//	If going down, make sure we're not on the bottom floor
						//if (sign(xx) < 0) {
							if bbox_bottom - sign(xx) <= onStairs.bbox_bottom {
								y -= sign(xx)	
							}
						//}
						//else y -= sign(xx)
					}
				}
				xx = 0
				
				//reticle.radius += 2
	
			}
		
		break
	#endregion
	
	#region Aim
		case states.aim:
			
			var offsetX = 0
			var offsetY = 0
			if inventory[inventoryIndex].item == item.flashlight {
				offsetX = arm1_offsetX
				offsetY = arm1_offsetY
			}
			else {
				offsetX = arm0_offsetX
				offsetY = arm0_offsetY
			}
			gunRotation = point_direction(x+(offsetX*image_xscale),y+offsetY, mouse_x,mouse_y)
			
			//	Firing gun
			if firingGun > -1 and firingGun.done {
				instance_destroy(firingGun)
				firingGun = -1
				arm0 = s_player_arm_aim
			}
			
			//	Stop aiming
			if input.mouseRightRelease and firingGun == -1 {
				states = states.free
				window_set_cursor(cr_default)
			}
			
			switch(inventory[inventoryIndex].item) {
				case item.hand:
				
				break
				case item.gun:
					//if arm0 == s_player_arm_aim_fire arm0 = s_player_arm_aim	
				break
				case item.flashlight:
				
					//	Looting
					if game.lootingMoving lootMoving()
				
					if input.keyRight or input.keyLeft {
						hspd += input.keyRight - input.keyLeft
				
						var flashlightClamp = 0
						if (image_xscale and hspd < 0) or (image_xscale == -1 and hspd > 0) {
							flashlightClamp = maxSpeed
						}
	
						hspd = clamp(hspd,-(maxSpeed-flashlightClamp),maxSpeed-flashlightClamp)
	
						xx += hspd
				
						//if hspd != 0 sprite_index = s_player_flashlight_walk
						//else sprite_index = s_player_flashlight	
						
						//	Stairs
						if (input.keyUp or input.keyDown) and place_meeting(x,y,stairs) {
							var Stairs = instance_place(x,y,stairs)
							if Floor == Stairs.bottomFloor {
								if x <= Stairs.leftX {
									onStairs = Stairs
								}
							}
							else if Floor == Stairs.topFloor {
								if x >= Stairs.rightX-8 and x <= Stairs.rightX+8 {
									onStairs = Stairs
								}
							}
						}
						if onStairs and !place_meeting(x,y,stairs) onStairs = false
						
					}
					
					else if !game.lootingMoving {
	
						if abs(hspd) != 0 {
							hspd = lerp(hspd,0,0.1)
		
							if abs(hspd) - maxSpeed < 0.5 hspd = 0
		
							xx += hspd		
					
							sprite_index = s_player_flashlight_walk
						}
						else {
							sprite_index = s_player_flashlight	
						}
						
						//	Stairs
						if (input.keyUp or input.keyDown) and place_meeting(x,y,stairs) {
							var Stairs = instance_place(x,y,stairs)
							if Floor == Stairs.bottomFloor {
								if x <= Stairs.leftX {
									onStairs = Stairs
								}
							}
							else if Floor == Stairs.topFloor {
								if x >= Stairs.rightX-8 and x <= Stairs.rightX+8 {
									onStairs = Stairs
								}
							}
						}
						if onStairs and !place_meeting(x,y,stairs) onStairs = false
	
					}
					
					if hspd != 0 sprite_index = s_player_flashlight_walk
					else sprite_index = s_player_flashlight	
				break
			}
			
			////	Collision Checking
			if xx != 0 {
				
				image_speed = abs(hspd)/maxSpeed
	
				for(var XX=0;XX<abs(xx);XX++) {
					if !instance_place(x + sign(xx), y, block) x += sign(xx)
					else {
						//var ID = instance_place(x + sign(xx), y, block)
						//if ID.Floor > Floor x += sign(xx)
						if onStairs x += sign(xx)
					}
					if onStairs {
						//	If going down, make sure we're not on the bottom floor
						//if (sign(xx) < 0) {
							if bbox_bottom - sign(xx) <= onStairs.bbox_bottom {
								y -= sign(xx)	
							}
						//}
						//else y -= sign(xx)
					}
				}
				xx = 0
	
			}
			
			//	Use item in hand
			if input.mouseLeftPress {
				if inventory[inventoryIndex].item == item.gun and firingGun == -1 {
					fireGun()
					arm0 = s_player_arm_aim_fire
					
					firingGun = instance_create_layer(0,0,"Instances",animationTimer)
					firingGun.ID = id
					firingGun.sprite_index = arm0
					firingGun.image_index = 0
					
					//reticle.radius += reticle.radius/2 + 8
					var dist = point_distance(x,y, mouse_x,mouse_y)
					reticle.radius += (dist/360) * 20
					reticle.radiusSpeed -= .25
					reticle.speedDelay = 0
				
					var e = []
					e[bodypart.torso] = "torso"
					e[bodypart.head] = "head"
					e[bodypart.front_arm_upper] = "rightArmUpper"
					e[bodypart.front_arm_lower] = "rightArmLower"
					e[bodypart.front_arm_hand] = "rightArmHand"
					e[bodypart.back_arm_upper] = "leftArmUpper"
					e[bodypart.back_arm_lower] = "leftArmLower"
					e[bodypart.back_arm_hand] = "leftArmHand"
					e[bodypart.front_leg_upper] = "rightLegUpper"
					e[bodypart.front_leg_lower] = "rightLegLower"
					e[bodypart.back_leg_upper] = "leftLegUpper"
					e[bodypart.back_leg_lower] = "leftLegLower"
				
				}
			}
			
		break
	#endregion

}

if Floor == 1 {
	//layer_set_visible("Tiles_4",false)		
}

if !place_meeting(x,y-32,block) and !onStairs onGround = false

if !onGround applyThrust()