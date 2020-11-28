event_inherited()

timer = irandom_range(90,180)
goalX = -1
maxSpeed = 0.5

sprite = zombie_walk
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
		
		surface_save(bloodSurface,"zombieBloodSurface.png")
		
	//}
	
}

states = states.free

//	Create bodyparts for zombie
for(var b=0;b<12;b++) {
	switch(b) {
		//	Torso
		case 0:
			var struct = new create_bodypart_struct(Zombie_torso, 5,5, 0,-1,-1, 0,-1)
			create_bodypart(b, bodypart.torso, -1, struct)
		break
		//	Head
		case 1:
			var struct = new create_bodypart_struct(Zombie_head, 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.head, -1, struct)
		break
		//	Front Arm Upper
		case 2:
			var struct = new create_bodypart_struct(Zombie_Front_Arm_front_upper_arm, 5,5, 0,-90,90, true,0)
			create_bodypart(b, bodypart.front_arm_upper, -1, struct)
		break
		//	Front Arm Lower
		case 3:
			var struct = new create_bodypart_struct(Zombie_Front_Arm_front_lower_arm, 5,5, 0,-45,45, true,2)
			create_bodypart(b, bodypart.front_arm_lower, -1, struct)
		break
		//	Front Arm Hand
		case 4:
			var struct = new create_bodypart_struct(Zombie_Front_Arm_front_hand, 5,5, 0,-20,20, true,3)
			create_bodypart(b, bodypart.front_arm_hand, -1, struct)
		break
		//	Back Arm Upper
		case 5:
			var struct = new create_bodypart_struct(Zombie_Back_arm_back_upper_arm, 5,5, 0,-90,90, true,0)
			create_bodypart(b, bodypart.back_arm_upper, -1, struct)
		break
		//	Back Arm Lower
		case 6:
			var struct = new create_bodypart_struct(Zombie_Back_arm_back_lower_arm, 5,5, 0,-45,45, true,5)
			create_bodypart(b, bodypart.back_arm_lower, -1, struct)
		break
		//	Back Arm Hand
		case 7:
			var struct = new create_bodypart_struct(Zombie_Back_arm_back_hand, 5,5, 0,-20,20, true,6)
			create_bodypart(b, bodypart.back_arm_hand, -1, struct)
		break
		//	Front Leg Upper
		case 8:
			var struct = new create_bodypart_struct(Zombie_Front_Leg_front_upper_leg, 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.front_leg_upper, -1, struct)
		break
		//	Front Leg Lower
		case 9:
			var struct = new create_bodypart_struct(Zombie_Front_Leg_front_lower_leg, 5,5, 0,-20,20, true,8)
			create_bodypart(b, bodypart.front_leg_lower, -1, struct)
		break
		//	Back Leg Upper
		case 10:
			var struct = new create_bodypart_struct(Zombie_Back_Leg_back_upper_leg, 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.back_leg_upper, -1, struct)
		break
		//	Back Leg Lower
		case 11:
			var struct = new create_bodypart_struct(Zombie_Back_Leg_back_lower_leg, 5,5, 0,-20,20, true,10)
			create_bodypart(b, bodypart.back_leg_lower, -1, struct)
		break
	}
}

function die() {
	var ragDoll = instance_create_layer(x,y,"Instances",class_ragdoll)
	ragDoll.unit_index = object_index
	ragDoll.sprite_index = sprite_index
	ragDoll.bodyparts = bodyparts
	ragDoll.image_xscale = image_xscale
	ragDoll.spawn_ragdoll()	
	
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