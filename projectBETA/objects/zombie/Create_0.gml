event_inherited()

timer = irandom_range(90,180)
goalX = -1
maxSpeed = 0.5
states = states.free

sprite = zombie_Walk
sprite_index = sprite

knocked = false

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
	
function knockBack(XX) {
	var ID = id
	ID.knocked = true
	//	Zombies facing left and we shot him in the front
	if XX < ID.x and ID.image_xscale < 0 {
		ID.sprite_index = zombie_Knockback_Back
	}
	//	Zombies facing left and we shot him in the back
	else if XX > ID.x and ID.image_xscale < 0 {
		ID.sprite_index = zombie_Knockback_front
	}
	//	Zombies facing right and we shot him in the back
	else if XX < ID.x and ID.image_xscale > 0 {
		ID.sprite_index = zombie_Knockback_front
	}
	else {
		ID.sprite_index = zombie_Knockback_Back	
	}
	image_index = 0
	states = states.free
	goalX = -1
}

states = states.free

//	Create bodyparts for zombie
for(var b=0;b<12;b++) {
	switch(b) {
		//	Torso
		case 0:
			var struct = new create_bodypart_struct("_torso_", 5,5, 0,-1,-1, 0,-1)
			create_bodypart(b, bodypart.torso, -1, struct)
		break
		//	Head
		case 1:
			var struct = new create_bodypart_struct("_head_", 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.head, -1, struct)
		break
		//	Front Arm Upper
		case 2:
			var struct = new create_bodypart_struct("_Front_Arm_front_upper_arm_", 5,5, 0,-90,90, true,0)
			create_bodypart(b, bodypart.front_arm_upper, -1, struct)
		break
		//	Front Arm Lower
		case 3:
			var struct = new create_bodypart_struct("_Front_Arm_front_lower_arm_", 5,5, 0,-45,45, true,2)
			create_bodypart(b, bodypart.front_arm_lower, -1, struct)
		break
		//	Front Arm Hand
		case 4:
			var struct = new create_bodypart_struct("_Front_Arm_front_hand_", 5,5, 0,-20,20, true,3)
			create_bodypart(b, bodypart.front_arm_hand, -1, struct)
		break
		//	Back Arm Upper
		case 5:
			var struct = new create_bodypart_struct("_Back_arm_back_upper_arm_", 5,5, 0,-90,90, true,0)
			create_bodypart(b, bodypart.back_arm_upper, -1, struct)
		break
		//	Back Arm Lower
		case 6:
			var struct = new create_bodypart_struct("_Back_arm_back_lower_arm_", 5,5, 0,-45,45, true,5)
			create_bodypart(b, bodypart.back_arm_lower, -1, struct)
		break
		//	Back Arm Hand
		case 7:
			var struct = new create_bodypart_struct("_Back_arm_back_hand_", 5,5, 0,-20,20, true,6)
			create_bodypart(b, bodypart.back_arm_hand, -1, struct)
		break
		//	Front Leg Upper
		case 8:
			var struct = new create_bodypart_struct("_Front_Leg_front_upper_leg_", 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.front_leg_upper, -1, struct)
		break
		//	Front Leg Lower
		case 9:
			var struct = new create_bodypart_struct("_Front_Leg_front_lower_leg_", 5,5, 0,-20,20, true,8)
			create_bodypart(b, bodypart.front_leg_lower, -1, struct)
		break
		//	Back Leg Upper
		case 10:
			var struct = new create_bodypart_struct("_Back_Leg_back_upper_leg_", 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.back_leg_upper, -1, struct)
		break
		//	Back Leg Lower
		case 11:
			var struct = new create_bodypart_struct("_Back_Leg_back_lower_leg_", 5,5, 0,-20,20, true,10)
			create_bodypart(b, bodypart.back_leg_lower, -1, struct)
		break
	}
}

function die() {
	var ragDoll = instance_create_layer(x,y,"Instances",class_ragdoll)
	ragDoll.unit_index = object_index
	ragDoll.sprite_index = sprite_index
	ragDoll.image_index = image_index
	ragDoll.bodyparts = bodyparts
	ragDoll.image_xscale = image_xscale
	ragDoll.spawn_ragdoll()
	instance_destroy()	
	return ragDoll
}