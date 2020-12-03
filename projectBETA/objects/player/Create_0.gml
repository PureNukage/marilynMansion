event_inherited()

mask_index = s_player_collision

depth = -5

input = instance_create_layer(0,0,"Instances",playerInput)

hspd = 0
maxSpeed = 1.25

flashlightOn = game.Player.flashlightOn

arm0 = s_player_arm_aim
arm0_offsetX = -6
arm0_offsetY = -11

arm1 = s_player_arm_support
arm1_offsetX = 6
arm1_offsetY = -11

gunRotation = -1

bulletArcDraw = -1
bulletArray = []

groundY = y

inventory[0] = new create_item(item.hand)
inventory[1] = new create_item(item.gun)
inventory[2] = new create_item(item.flashlight)

inventoryIndex = 0

function change_inventory(new_index) {
	var new_item = inventory[new_index].item
	switch(new_item) {
		case item.hand:
			arm0 = -1
			arm1 = -1
		break
		case item.gun:
			arm0 = s_player_arm_aim
			arm1 = s_player_arm_support
		break
		case item.flashlight:
			arm0 = s_player_arm_flashlight
			arm1 = -1
		break
	}
	var e = []
	e[item.hand] = "hand"
	e[item.gun] = "gun"
	e[item.flashlight] = "flashlight"
	debug.log("changing hand from: "+string_upper(e[inventoryIndex])+" to "+string_upper(e[new_index]))
	
	inventoryIndex = new_index
	
	game.Player.inventoryIndex = inventoryIndex
}

change_inventory(game.Player.inventoryIndex)

lootingClampX1 = -1
lootingClampX2 = -1
lootingClampY1 = -1
lootingClampY2 = -1
lootingString = ""
lootingID = -1
lootingMoving = false

xx = 0
yy = 0

states = states.free

function lootMoving() {
	//	Moving to goal
	if game.lootingMoving {
				
		//	Arrived at goal
		if abs(x - game.lootingID.x) < 20 {
			game.lootingMoving = false
					
			if game.lootingID.object_index == candle {
				game.lootingID.interact(!game.lootingID.on)
			
				//	Sound
				if game.lootingID.on sound.playSoundEffect(snd_fire)
				else sound.playSoundEffect(snd_woosh)
			 	
			}
			else if game.lootingID.object_index == door {
				game.lootingID.interact(game.lootingID.ID)	
			}
					
			game.lootingID = -1
		}
		//	Moving to goal
		else {
				
			hspd += sign(game.lootingID.x - x)
				
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
}

function fireGun() {
	
	var startX = x + (-8 * image_xscale)
	var startY = y - 17
	
	reticle.radiusSpeed = 0.5
	
	lighting.gunFired = true
	
	var length = irandom_range(reticle.radiusMin,reticle.radius)
	var durection = irandom_range(0,359)
	
	var endX = mouse_x + lengthdir_x(length, durection)
	var endY = mouse_y + lengthdir_y(length, durection)
	
	var precision = 1
	var Direction = point_direction(startX,startY,endX,endY)
	
	var XX = endX
	var YY = endY
	
	startX += lengthdir_x(32, Direction)
	startY += lengthdir_y(32, Direction)
	
	sound.playSoundEffect(choose(snd_45_1,snd_45_2,snd_45_3))
	
	if instance_position(XX,YY, zombie) {
			var ID = instance_position(XX,YY, zombie)
			//loop = false
			var array = []
			array[0] = instance_position(XX,YY, zombie)
			array[1] = XX
			array[2] = YY
			
			var createBloodSquib = false
			var dead = false
			//	Bodypart hit detection
			for(var i=0;i<array_length(ID.bodyparts);i++) {
				var struct = ID.bodyparts[i][bodyparts_struct]
				var spriteString = struct.spriteBaseString + string(floor(ID.image_index + 1))
				var genX = ID.x - (sprite_get_xoffset(ID.sprite_index)*ID.image_xscale)
				var genY = ID.y - sprite_get_yoffset(ID.sprite_index)
				var spriteIndex = asset_get_index(spriteString)
			
				var oldOffsetX = sprite_get_xoffset(spriteIndex)
				var oldOffsetY = sprite_get_yoffset(spriteIndex)
				sprite_set_offset(spriteIndex,0,0)
			
				var _bbox_left = sprite_get_bbox_left(spriteIndex)*ID.image_xscale var _bbox_right = sprite_get_bbox_right(spriteIndex)*ID.image_xscale
				var _bbox_top = sprite_get_bbox_top(spriteIndex) var _bbox_bottom = sprite_get_bbox_bottom(spriteIndex)
				//	This part was hit!
				if point_in_rectangle(XX,YY, min(genX+_bbox_left,genX+_bbox_right),genY+_bbox_top,max(genX+_bbox_left,genX+_bbox_right),genY+_bbox_bottom) {
					debug.log("we hit bodypart "+string_upper(spriteString))
				
					//	Apply damage based on bodypart
					if !createBloodSquib {
						if ID.bodyparts[i][bodyparts_enum] == bodypart.head {
							ID.hp -= 5	
						}
						else ID.hp -= 2
						createBloodSquib = true	
					}
				}
				sprite_set_offset(spriteIndex,oldOffsetX,oldOffsetY)
				if ID.hp <= 0 {
					ID.die()
				
					//	Create blood wall splat
					var splat = instance_create_layer(XX,YY,"Instances",class_particle)
					splat.sprite_index = s_bloodsplat_0
					//if startX > ID.x splat.image_xscale = -1
					//else splat.image_xscale = 1
					splat.image_angle = point_direction(startX,startY, XX,YY)
				
					//	Create blood decal
					var Decal = instance_create_layer(XX,YY,"Instances",class_decal)
					Decal.sprite_index = s_bloodhole_0
					Decal.applyDecal(ID.bodyparts[i][bodyparts_id])
				
					//	Apply force to bodypart
					with ID.bodyparts[i][bodyparts_id] {
						var xForce = 0
						if startX > x xForce = -5000
						else xForce = 5000
						physics_apply_force(XX,YY, xForce,0)	
					}
				
					i = 1000
					dead = true
				}
			}
			
			if createBloodSquib {
				//	Blood squib
				var Particle = instance_create_layer(XX,YY,"Instances",class_particle)
				Particle.sprite_index = s_bloodsquib
				//if startX > ID.x Particle.image_xscale = 1
				//else Particle.image_xscale = -1
				Particle.depth = -5
				Particle.fix.id = ID
				Particle.fix.x = XX - ID.x
				Particle.fix.y = YY - ID.y
				Particle.image_angle = point_direction(XX,YY, startX,startY)
			}
			
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			////	Create bloodsplat particle
			//var Particle = instance_create_layer(XX,YY,"Instances",particle)
			//if array[0].hp - 1 <= 0 Particle.sprite_index = s_bloodsplat_0
			//else Particle.sprite_index = s_bloodsplat_1
			//Particle.image_angle = point_direction(startX,startY, XX,YY)
			//if x > array[0].x {
			//	Particle.image_xscale = -1
			//	Particle.image_angle += 180	
			//}
			
			//	Create blood decal
			//array[0].add_blood(XX,YY)
			
			return array
		} else if instance_position(XX,YY, class_bodypart) {
			//loop = false
			var ID = instance_position(XX,YY,class_bodypart) 
			var array = []
			array[0] = instance_position(XX,YY, class_bodypart)
			array[1] = XX
			array[2] = YY
			
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			//	Create blood decal
			var Decal = instance_create_layer(XX,YY,"Instances",class_decal)
			Decal.sprite_index = s_bloodhole_0
			Decal.applyDecal(ID)
			
			//	Blood squib
			var Particle = instance_create_layer(XX,YY,"Instances",class_particle)
			Particle.sprite_index = s_bloodsquib
			//if startX > ID.x Particle.image_xscale = 1
			//else Particle.image_xscale = -1
			Particle.depth = -5
			Particle.fix.id = ID
			Particle.fix.x = XX - ID.x
			Particle.fix.y = YY - ID.y
			Particle.image_angle = point_direction(XX,YY, startX,startY)
			
			//	Apply force to bodypart
			with ID {
				var xForce = 0
				if startX > x xForce = -2000
				else xForce = 2000
				physics_apply_force(XX,YY, xForce,0)	
			}
			
			return array
		
		} else if instance_place(XX,YY, lock) and !instance_place(XX,YY, lock).dead {
			//loop = false
			
			//bulletArray[0] = XX
			//bulletArray[1] = YY
			//bulletArray[2] = startX
			//bulletArray[3] = startY
			
			instance_place(XX,YY, lock).die()
			
			return false
		
		} else if point_distance(XX,YY, endX,endY) < 2 {
			//loop = false
			
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			//	Create bulletScorch particle
			var Particle = instance_create_layer(XX,YY,"Instances",class_particle)
			Particle.sprite_index = s_bulletScorch
			Particle.image_angle = irandom_range(0,359)
			
			return false
		} //else if instance_place(XX,YY, lock) and !instance_place(XX,YY, lock).dead {
		//	//loop = false
			
		//	//bulletArray[0] = XX
		//	//bulletArray[1] = YY
		//	//bulletArray[2] = startX
		//	//bulletArray[3] = startY
			
		//	instance_place(XX,YY, lock).die()
			
		//	return false
		//} else {
		//	XX += lengthdir_x(precision, Direction)
		//	YY += lengthdir_y(precision, Direction)		
		//}
	
	//var loop = true
	//while loop {
		
		//if instance_position(XX,YY, zombie) {
		//	loop = false
		//	var array = []
		//	array[0] = instance_position(XX,YY, zombie)
		//	array[1] = XX
		//	array[2] = YY
			
		//	bulletArray[0] = XX
		//	bulletArray[1] = YY
		//	bulletArray[2] = startX
		//	bulletArray[3] = startY
		//	bulletArcDraw = 15
			
		//	//	Create bloodsplat particle
		//	var Particle = instance_create_layer(XX,YY,"Instances",particle)
		//	if array[0].hp - 1 <= 0 Particle.sprite_index = s_bloodsplat_0
		//	else Particle.sprite_index = s_bloodsplat_1
		//	Particle.image_angle = point_direction(startX,startY, XX,YY)
		//	if x > array[0].x {
		//		Particle.image_xscale = -1
		//		Particle.image_angle += 180	
		//	}
			
		//	//	Create blood decal
		//	array[0].add_blood(XX,YY)
			
		//	return array
		//} else if instance_position(XX,YY, zombiePart) {
		//	loop = false
		//	var array = []
		//	array[0] = instance_position(XX,YY, zombiePart)
		//	array[1] = XX
		//	array[2] = YY
			
		//	bulletArray[0] = XX
		//	bulletArray[1] = YY
		//	bulletArray[2] = startX
		//	bulletArray[3] = startY
		//	bulletArcDraw = 15
			
		//	//	Create bloodsplat particle
		//	var Particle = instance_create_layer(XX,YY,"Instances",particle)
		//	Particle.sprite_index = s_bloodsplat_1
		//	Particle.image_angle = point_direction(startX,startY, XX,YY)
		//	if x > array[0].x {
		//		Particle.image_xscale = -1
		//		Particle.image_angle += 180	
		//	}
			
		//	return array
		
		//} else if point_distance(XX,YY, endX,endY) < 2 {
		//	loop = false
			
		//	bulletArray[0] = XX
		//	bulletArray[1] = YY
		//	bulletArray[2] = startX
		//	bulletArray[3] = startY
		//	bulletArcDraw = 15
			
		//	//	Create bulletScorch particle
		//	var Particle = instance_create_layer(XX,YY,"Instances",particle)
		//	Particle.sprite_index = s_bulletScorch
		//	Particle.image_angle = irandom_range(0,359)
			
		//	return false
		//} else if instance_place(XX,YY, lock) and !instance_place(XX,YY, lock).dead {
		//	loop = false
			
		//	//bulletArray[0] = XX
		//	//bulletArray[1] = YY
		//	//bulletArray[2] = startX
		//	//bulletArray[3] = startY
			
		//	instance_place(XX,YY, lock).die()
			
		//	return false
		//} else {
		//	XX += lengthdir_x(precision, Direction)
		//	YY += lengthdir_y(precision, Direction)		
		//}
		
		
	//}
	
}


#region Reticle

	reticle = {
		radius: 16,
		radiusSpeed: 0.5,
		radiusMin: 4,
		radiusMax: 96,
		X: -1,
		Y: -1,
		XPrevious: -1,
		YPrevious: -1,
		
		firstCalculate: function() {
			var XX = other.x + (-8*other.image_xscale)
			var YY = other.y - 17
			var Direction = point_direction(XX,YY, mouse_x,mouse_y)
			XX += lengthdir_x(64, Direction)
			YY += lengthdir_y(64, Direction)
			
			var distance = point_distance(XX,YY, mouse_x,mouse_y)
			
			var max_distance = 800
			if distance < max_distance {
				var ratio = distance/max_distance
				var reticleRatio = radiusMax * ratio
				radius = reticleRatio
			}	
		},
		
		aimIncreasing: function() {
			var XX = other.x + (-8*other.image_xscale)
			var YY = other.y - 17
			var Direction = point_direction(XX,YY, mouse_x,mouse_y)
			XX += lengthdir_x(64, Direction)
			YY += lengthdir_y(64, Direction)
			
			radius -= radiusSpeed
			radiusSpeed += 0.10
			
			X = mouse_x
			Y = mouse_y
			if (X != XPrevious or Y != YPrevious) and (XPrevious != -1 and YPrevious != -1) {
				radius += abs((XPrevious - X)+(YPrevious - Y))/5
				XPrevious = X
				YPrevious = Y
			}
			if XPrevious == -1 or YPrevious == -1 {
				XPrevious = X
				YPrevious = Y
			}
			
			var distance = point_distance(XX,YY, mouse_x,mouse_y)
			
			var max_distance = 800
			if distance < max_distance {
				var ratio = distance/max_distance
				var reticleRatio = radiusMax * ratio
				var Radius = reticleRatio
				Radius = clamp(Radius,radiusMin,radiusMax)
				Radius = radiusMax
			} else Radius = radiusMax
			
			radius = clamp(radius,radiusMin,Radius)
		}
	}
	
#endregion