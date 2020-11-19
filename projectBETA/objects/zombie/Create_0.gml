event_inherited()

sprite = s_zombie_walk
sprite_index = sprite

bloodSurface = -1
bloodSurface = surface_create(sprite_get_width(sprite_index),sprite_get_height(sprite_index))
surface_set_target(bloodSurface)
draw_clear_alpha(c_white, 0)
surface_reset_target()

function add_blood(x, y) {
	
	//	Is this even colliding with us?
	//if !((x > bbox_left and x < bbox_right) and (y > bbox_top and y < bbox_bottom)) {
	//	debug.log("ERROR decal is not colliding with bbox")
	//}
	//else {
	
		//	Translate room coordinates into surface coordinates and then draw it
		var originX = sprite_get_xoffset(sprite_index)
		var originY = sprite_get_yoffset(sprite_index)
		var X = id.x - originX
		var Y = id.y - originY
		
		var newX = abs(x - X)
		var newY = abs(y - Y)
		
		if surface_exists(bloodSurface) {
			surface_set_target(bloodSurface)
			draw_sprite(s_bloodhole_0,0,newX,newY)	
			surface_reset_target()
		}
		
	//}
	
}

states = states.free

#region Zombie Bodyparts

	var b = 0 // Part Index

	//	Torso
	bodyparts[b][bodyparts_enum] = bodyParts.torso
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_torso,
		fix_width: 30,
		fix_height: 45,
		fix_offsetX: 0,
		fix_offsetY: 0,
		fix_density: 10,
		fix_friction: 10,
		fix_angle: 0,
		min_angle: -1,
		max_angle: -1,
		angle: false,
		bind: -1
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Head
	bodyparts[b][bodyparts_enum] = bodyParts.head
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_head,
		fix_width: 30,
		fix_height: 30,
		fix_offsetX: 2,
		fix_offsetY: -16,
		fix_density: 16,
		fix_friction: 6,
		fix_angle: 0,
		angle: true,
		min_angle: -20,
		max_angle: 20,
		bind: 0
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Right Arm Upper
	bodyparts[b][bodyparts_enum] = bodyParts.rightArmUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_right_arm_upper,
		fix_width: 19,
		fix_height: 28,
		fix_offsetX: 5,
		fix_offsetY: 9,
		fix_density: 6,
		fix_friction: 10,
		fix_angle: 0,
		angle: true,
		min_angle: -75,
		max_angle: 75,
		bind: 0
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++

	//	Right Arm Lower
	bodyparts[b][bodyparts_enum] = bodyParts.rightArmLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_right_arm_lower,
		fix_width: 23,
		fix_height: 13,
		fix_offsetX: 10,
		fix_offsetY: -4,
		fix_density: 4,
		fix_friction: 6,
		fix_angle: 0,
		angle: true,
		min_angle: -45,
		max_angle: 45,
		bind: 2
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Right Arm Hand
	bodyparts[b][bodyparts_enum] = bodyParts.rightArmHand
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_right_arm_hand,
		fix_width: 11,
		fix_height: 12,
		fix_offsetX: 3,
		fix_offsetY: 8,
		fix_density: 2,
		fix_friction: 10,
		fix_angle: 0,
		angle: true,
		min_angle: -45,
		max_angle: 45,
		bind: 3
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Left Arm Upper
	bodyparts[b][bodyparts_enum] = bodyParts.leftArmUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_arm_upper,
		fix_width:  13,
		fix_height:  26,
		fix_offsetX:  4,
		fix_offsetY:  6,
		fix_density: 6,
		fix_friction: 10,
		fix_angle: 0,
		angle:  true,
		min_angle:  -75,
		max_angle:  75,
		bind:  0
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Left Arm Lower
	bodyparts[b][bodyparts_enum] = bodyParts.leftArmLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_arm_lower,
		fix_width:  23,
		fix_height:  16,
		fix_offsetX:  7,
		fix_offsetY:  -5,
		fix_density: 4,
		fix_friction: 6,
		fix_angle: 0,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  5
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Left Arm Hand
	bodyparts[b][bodyparts_enum] = bodyParts.leftArmHand
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_arm_hand,
		fix_width:  14,
		fix_height:  15,
		fix_offsetX:  5,
		fix_offsetY:  5,
		fix_density: 8,
		fix_friction: 10,
		fix_angle: 0,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  6
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Right Leg Upper
	bodyparts[b][bodyparts_enum] = bodyParts.rightLegUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_right_leg_upper,
		fix_width:  14,
		fix_height:  25,
		fix_offsetX:  0,
		fix_offsetY:  11,
		fix_density: 6,
		fix_friction: 10,
		fix_angle: 0,
		angle:  true,
		min_angle:  -10,
		max_angle:  10,
		bind:  0
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Right Leg Lower
	bodyparts[b][bodyparts_enum] = bodyParts.rightLegLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_right_leg_lower,
		fix_width:  13,
		fix_height:  25,
		fix_offsetX:  2,
		fix_offsetY:  12,
		fix_density: 6,
		fix_friction: 6,
		fix_angle: 0,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  8
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Left Leg Upper
	bodyparts[b][bodyparts_enum] = bodyParts.leftLegUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_leg_upper,
		fix_width:  18,
		fix_height:  25,
		fix_offsetX:  0,
		fix_offsetY:  10,
		fix_density: 6,
		fix_friction: 10,
		fix_angle: 0,
		angle:  true,
		min_angle:  -10,
		max_angle:  10,
		bind:  0
	}
	bodyparts[b][bodyparts_fixture] = -1
	b++
	
	//	Left Leg Lower
	bodyparts[b][bodyparts_enum] = bodyParts.leftLegLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_leg_lower,
		fix_width:  18,
		fix_height:  29,
		fix_offsetX:  0,
		fix_offsetY:  14,
		fix_density: 6,
		fix_friction: 6,
		fix_angle: 0,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  10
	}
	bodyparts[b][bodyparts_fixture] = -1

#endregion

function die() {
	var ragDoll = instance_create_layer(x,y,"Instances",zombieRagdoll)
	ragDoll.bodyparts = bodyparts
	ragDoll.image_xscale = image_xscale
	ragDoll.spawnRagdoll()
	
	//	Blood surface
	for(var b=0;b<array_length(ragDoll.bodyparts);b++) {
		var ID = ragDoll.bodyparts[b][bodyparts_id]
		
		var surface = surface_create(room_width,room_height)
		var surfaceCropped = surface_create(sprite_get_width(ID.sprite_index),sprite_get_height(ID.sprite_index))
		var surfaceFinal = surface_create(sprite_get_width(ID.sprite_index),sprite_get_height(ID.sprite_index))
		surface_set_target(surface)
		draw_clear_alpha(c_white, 0)
		
		//draw_set_color(c_black)
		//draw_rectangle(0,0,room_width,room_height,false)
		
		var offsetX = sprite_get_xoffset(ID.sprite_index)
		var offsetY = sprite_get_yoffset(ID.sprite_index)
		
		var Width = sprite_get_width(ID.sprite_index)
		var Height = sprite_get_height(ID.sprite_index)
		
		var X = x - sprite_get_xoffset(sprite_index)
		var Y = y - sprite_get_yoffset(sprite_index)
		
		var bloodSprite = sprite_create_from_surface(bloodSurface,0,0,Width,Height,false,false,Width/2,Height/2)
		
		draw_sprite(ID.sprite_index,0,ID.x,ID.y)
		
		gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
		//if ID.image_xscale < 0 X += Width
		var extraX = 0
		if ID.image_xscale == -1 extraX = -5
		draw_sprite_ext(bloodSprite,0, X+Width/2 + extraX,Y+Height/2, ID.image_xscale,1, 0, c_white,1)
		gpu_set_blendmode(bm_normal)
		
		surface_reset_target()
		
		//if ID.image_xscale > -1 {
			var XX = ID.x - offsetX
			var YY = ID.y - offsetY
		//} else {
			//var XX = ID.x 		
		//}
		
		//	Reset the surface back to default sprite variables
		surface_set_target(surfaceCropped)
		draw_clear_alpha(c_white, 0)
		surface_reset_target()
		surface_copy_part(surfaceCropped,0,0, surface,XX,YY, Width,Height)
		
		surface_set_target(surfaceFinal)
		draw_clear_alpha(c_white, 0)
		
		var X = 0
		var Y = 0
		//if ID.image_xscale == -1 X = Width
		
		draw_sprite(ID.sprite_index,0,offsetX,offsetY)
		draw_surface_ext(surfaceCropped,X,Y,  1,  1,   0,   c_white,1)
		
		surface_reset_target()
		
		var Sprite = sprite_create_from_surface(surfaceFinal,0,0,Width,Height,false,true,offsetX,offsetY)
		ID.sprite_index = Sprite
		//ID.spriteBase = Sprite
		//ID.sprite = Sprite
		
		//surface_save(surface, string(b)+".png")
		//surface_save(surfaceCropped, string(b)+"cropped.png")
		//sprite_save(Sprite,0, string(b)+"sprite.png")
		//sprite_save(bloodSprite,0, "bloodSprite.png")
		//surface_save(bloodSurface, "bloodSurface.png")
		
		surface_free(surface)
		surface_free(surfaceCropped)
		surface_free(surfaceFinal)
		sprite_delete(bloodSprite)
		
	}
	
	instance_destroy()	
}