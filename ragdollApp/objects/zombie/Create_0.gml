event_inherited()

//	Create bodyparts for zombie
for(var b=0;b<12;b++) {
	switch(b) {
		//	Head
		case 0:
			var struct = new create_bodypart_struct(s_zombie_head, 5,5, 0,0, 5,5, 0,0,0, 0,1)
			create_bodypart(b, bodypart.head, -1, struct)
		break
		//	Torso
		case 1:
			var struct = new create_bodypart_struct(s_zombie_torso, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.torso, -1, struct)
		break
		//	Front Arm Upper
		case 2:
			var struct = new create_bodypart_struct(s_zombie_front_arm_upper, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.front_arm_upper, -1, struct)
		break
		//	Front Arm Lower
		case 3:
			var struct = new create_bodypart_struct(s_zombie_front_arm_lower, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.front_arm_lower, -1, struct)
		break
		//	Front Arm Hand
		case 4:
			var struct = new create_bodypart_struct(s_zombie_front_arm_hand, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.front_arm_hand, -1, struct)
		break
		//	Back Arm Upper
		case 5:
			var struct = new create_bodypart_struct(s_zombie_back_arm_upper, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.back_arm_upper, -1, struct)
		break
		//	Back Arm Lower
		case 6:
			var struct = new create_bodypart_struct(s_zombie_back_arm_lower, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.back_arm_lower, -1, struct)
		break
		//	Back Arm Hand
		case 7:
			var struct = new create_bodypart_struct(s_zombie_back_arm_hand, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.back_arm_hand, -1, struct)
		break
		//	Front Leg Upper
		case 8:
			var struct = new create_bodypart_struct(s_zombie_front_leg_upper, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.front_leg_upper, -1, struct)
		break
		//	Front Leg Lower
		case 9:
			var struct = new create_bodypart_struct(s_zombie_front_leg_lower, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.front_leg_lower, -1, struct)
		break
		//	Back Leg Upper
		case 10:
			var struct = new create_bodypart_struct(s_zombie_back_leg_upper, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
			create_bodypart(b, bodypart.back_leg_upper, -1, struct)
		break
		//	Back Leg Lower
		case 11:
			var struct = new create_bodypart_struct(s_zombie_back_leg_lower, 5,5, 0,0, 5,5, 0,0,0, 0,-1)
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
	instance_destroy()
}