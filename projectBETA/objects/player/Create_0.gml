event_inherited()

cooldown = 0

mask_index = s_player_collision

depth = -102

input = instance_create_layer(0,0,"Instances",playerInput)

//layer_depth("Tiles_4",-100)
Floor = 0

hspd = 0
maxSpeed = 1.25

ammo = 8
ammoMax = 8

flashlightOn = game.Player.flashlightOn

arm0 = s_player_arm_aim
arm0_offsetX = 4
arm0_offsetY = -6

arm1 = s_player_arm_support
arm1_offsetX = -4
arm1_offsetY = -8

gunRotation = -1

bulletArcDraw = -1
bulletArray = []

groundY = y
onStairs = false

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
			arm1 = s_player_arm_flashlight
			arm0 = -1
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

firingGun = -1
function fireGun() {
	
	var startX = x + (-8 * image_xscale)
	var startY = y - 17
	
	//reticle.radiusSpeed = 0.5
	
	lighting.gunFired = true
	
	var length = irandom_range(reticle.radiusMinBase,reticle.radius)
	var durection = irandom_range(0,359)
	
	var endX = mouse_x + lengthdir_x(length, durection)
	var endY = mouse_y + lengthdir_y(length, durection)
	
	//var precision = 1
	var Direction = point_direction(startX,startY,endX,endY)
	
	var XX = endX
	var YY = endY
	
	startX += lengthdir_x(32, Direction)
	startY += lengthdir_y(32, Direction)
	
	sound.playSoundEffect(choose(snd_45_1,snd_45_2,snd_45_3))
	
	if instance_position(XX,YY, zombie) {
			var ID = instance_position(XX,YY, zombie)
			
			//debug.log("hit zombie!")
			
			var createBloodSquib = false
			var dead = false
			//	Bodypart hit detection
			for(var i=0;i<array_length(ID.bodyparts);i++) {
				var struct = ID.bodyparts[i][bodyparts_struct]
				var firstString = string_copy(sprite_get_name(ID.sprite_index),string_pos("_",sprite_get_name(ID.sprite_index))+1,string_length(sprite_get_name(ID.sprite_index))-string_pos("_",sprite_get_name(ID.sprite_index))+1 )
				var spriteString = firstString + struct.sprite + string(floor(ID.image_index + 1))
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
					var ragDoll = ID.die()
				
					//	Create blood wall splat
					var splat = instance_create_layer(XX,YY,"Instances",class_particle)
					splat.sprite_index = s_bloodsplat_0
					splat.image_angle = point_direction(startX,startY, XX,YY)
				
					//	Create blood decal
					var Decal = instance_create_layer(XX,YY,"Instances",class_decal)
					Decal.sprite_index = s_bloodhole_0
					Decal.applyDecal(ragDoll.bodyparts[i][bodyparts_id])
				
					//	Apply force to bodypart
					with ragDoll.bodyparts[i][bodyparts_id] {
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
				Particle.depth = -5
				Particle.fix.id = ID
				Particle.fix.x = XX - ID.x
				Particle.fix.y = YY - ID.y
				Particle.image_angle = point_direction(XX,YY, startX,startY)
				
				//	Knock zombie
				if !dead {
					ID.knockBack(XX)
				}
			}
			//	Missed
			else {
				//	Create bulletScorch particle
				var Particle = instance_create_layer(XX,YY,"Instances",class_particle)
				Particle.sprite_index = s_bulletScorch
				Particle.image_angle = irandom_range(0,359)	
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
			
		} else if instance_position(XX,YY, class_bodypart) {
			var ID = instance_position(XX,YY,class_bodypart) 
			
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
			
		
		} else if instance_place(XX,YY, lock) and !instance_place(XX,YY, lock).dead {
			
			instance_place(XX,YY, lock).die()
			
		} else if point_distance(XX,YY, endX,endY) < 2 {
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			//	Create bulletScorch particle
			var Particle = instance_create_layer(XX,YY,"Instances",class_particle)
			Particle.sprite_index = s_bulletScorch
			Particle.image_angle = irandom_range(0,359)
			
		}
	
}
	
reloadStatePrev = -1
function reload() {
	ammo = ammoMax
	sprite_index = s_player_reloading
	image_index = 0
	image_speed = 1
	//reloadStatePrev = states
	states = states.reloading
	sound.playSoundEffect(snd_reload)
}
	
reticle = {
	radiusMinBase: 4,
	radiusMaxBase: 96,
	radiusMin: 4,
	radiusMax: 96,
	radiusSpeed: 0.5,
	radiusSpeedMax: 1,
	radius: 4,
	
	speedDelay: 0,
	
	x_prev: -1,
	y_prev: -1,
	
	x_prev_gui: -1,
	y_prev_gui: -1,
	
	aim_calculate: function() {
		
		var distToPlayer = point_distance(other.x,other.y, mouse_x,mouse_y)
		
		//	The first frame of us aiming
		if (x_prev == -1 or y_prev == -1) {
			x_prev = mouse_x
			y_prev = mouse_y
		}
		//	Every other frame
		else {
			var tolerance = 25
			//	If we haven't moved mouse x,y within a tolerance, decrease the reticle
			if abs(mouse_gui_x - x_prev_gui) <= tolerance and abs(mouse_gui_y - y_prev_gui) <= tolerance {
				radius -= radiusSpeed
				if radiusMin > radiusMinBase radiusMin -= radiusSpeed
				speedDelay++
				if speedDelay >= 5 {
					radiusSpeed += .05
					speedDelay = 0
				}
				radiusSpeedMax = 0.8
			}
			//	Adjusted aim, lets increase reticle
			else {
				//	Increase radius if we're aiming further away
				var oldDist = point_distance(other.x,other.y, x_prev,y_prev)
				if distToPlayer > oldDist {
					radius += radius/4 + 4
				}
				else radius += 2
				x_prev = mouse_x
				y_prev = mouse_y
				x_prev_gui = mouse_gui_x
				y_prev_gui = mouse_gui_y
				radiusSpeed -= 0.40
			}
		}
		
		radius = clamp(radius,radiusMin,radiusMax)
		radiusMin = clamp(radiusMin,radiusMinBase,radiusMin)
		radiusMax = clamp(radiusMax,radiusMinBase, radiusMaxBase)
		
		radiusSpeed = clamp(radiusSpeed,0,radiusSpeedMax)
		
	},
		
	first_calculate: function() {
		var distToPlayer = point_distance(other.x,other.y, mouse_x,mouse_y)
		radius = (distToPlayer / 360) * radiusMax/2
		radiusSpeed = 0
		
		x_prev_gui = mouse_gui_x
		y_prev_gui = mouse_gui_y
	}
}