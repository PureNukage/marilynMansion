on = false

depth = -500

selectedBodypart = -1

physics_on = false
phy_fix_on = false

wind = false
windRadius = 32

gunRadius = 4

function log(String) {
	
	var Time = "[" + string(time.stream) + "] "
	
	var Object = string_upper(object_get_name(other.object_index))
	
	var fullMessage = Time + Object + " " + String
	
	show_debug_message(fullMessage)
}

function button(x,y,width,height,text) {
	
	var mouseover = false
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_set_color(c_black)
	draw_roundrect(x-2,y-2,x+width+2,y+height+2,false)
	
	if point_in_rectangle(mouse_gui_x,mouse_gui_y,x,y,x+width,y+height) {
		draw_set_color(c_ltgray)
		mouseover = true
	}
	else {
		draw_set_color(c_gray)
		mouseover = false	
	}
	draw_roundrect(x,y,x+width,y+height,false)
	
	draw_set_color(c_black)
	draw_text(x+width/2,y+height/2,text)
	
	return mouseover
	
}
	
function fireGun(_x, _y) {
	
	var XX = _x + irandom_range(-gunRadius,gunRadius)
	var YY = _y + irandom_range(-gunRadius,gunRadius)
	
	var XX = _x
	var YY = _y
	
	//	Hit a zombie
	if instance_position(XX,YY,zombie) {
		var ID = instance_position(XX,YY,zombie)
		
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
				splat.sprite_index = s_bulletsplat
				if XX > ID.x splat.image_xscale = -1
				else splat.image_xscale = 1
				
				//	Create blood decal
				var Decal = instance_create_layer(XX,YY,"Instances",class_decal)
				Decal.sprite_index = s_bullethole
				Decal.applyDecal(ID.bodyparts[i][bodyparts_id])
				
				//	Apply force to bodypart
				with ID.bodyparts[i][bodyparts_id] {
					var xForce = 0
					if XX > x xForce = -5000
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
			if XX > ID.x Particle.image_xscale = 1
			else Particle.image_xscale = -1
			Particle.depth = -5
			Particle.fix.id = ID
			Particle.fix.x = XX - ID.x
			Particle.fix.y = YY - ID.y
			
			if !dead {
				////	Create blood wall splat
				//var splat = instance_create_layer(XX,YY,"Instances",class_particle)
				//splat.sprite_index = s_bulletsplat2
				//if XX > ID.x splat.image_xscale = -1
				//else splat.image_xscale = 1	
			}
		}
		
	} 
	//	Hit a ragdoll
	else if instance_position(XX,YY,class_bodypart) {
		var ID = instance_position(XX,YY,class_bodypart)
		
		//	Check for multiple ragdolls and choose a random one
		var list = ds_list_create()
		var amount = instance_position_list(XX,YY,class_bodypart,list,true)
		if amount > 1 {
			for(var i=0;i<amount;i++) {
				ID = list[| i]
				
				//	Create blood decal
				var Decal = instance_create_layer(XX,YY,"Instances",class_decal)
				Decal.sprite_index = s_bullethole
				Decal.applyDecal(ID)
			}	
		}
		else {
		
			//	Create blood decal
			var Decal = instance_create_layer(XX,YY,"Instances",class_decal)
			Decal.sprite_index = s_bullethole
			Decal.applyDecal(ID)
		}
		
		//	Blood squib
		var Particle = instance_create_layer(XX,YY,"Instances",class_particle)
		Particle.sprite_index = s_bloodsquib
		if XX > ID.x Particle.image_xscale = 1
		else Particle.image_xscale = -1
		Particle.depth = -5
		Particle.fix.id = ID
		Particle.fix.x = XX - ID.x
		Particle.fix.y = YY - ID.y
		
		//	Apply force to bodypart
		with ID {
			var xForce = 0
			if XX > ragdoll.x xForce = -2000
			else xForce = 2000
			physics_apply_force(XX,YY, xForce,0)	
		}
		
		////	Create blood wall splat
		//var splat = instance_create_layer(XX,YY,"Instances",class_particle)
		//splat.sprite_index = s_bulletsplat2
		//if XX > ID.x splat.image_xscale = -1
		//else splat.image_xscale = 1
		
		ds_list_destroy(list)
		
	} 
	//	Missed
	else {
		var Particle = instance_create_layer(XX,YY,"Instances",class_particle)
		Particle.sprite_index = s_gunscorch
	}
	
}