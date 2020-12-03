event_inherited()

state = state.idle
timer = irandom_range(90,180)
goalX = -1
maxSpeed = 0.5

image_index = irandom_range(0,image_number)

//	Create bodyparts for zombie
for(var b=0;b<12;b++) {
	switch(b) {
		//	Torso
		case 0:
			var struct = new create_bodypart_struct(s_zombie_torso, "Walk_torso_", 5,5, 0,-1,-1, 0,-1)
			create_bodypart(b, bodypart.torso, -1, struct)
		break
		//	Head
		case 1:
			var struct = new create_bodypart_struct(s_zombie_head, "Walk_head_", 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.head, -1, struct)
		break
		//	Front Arm Upper
		case 2:
			var struct = new create_bodypart_struct(s_zombie_front_arm_upper, "Walk_Front_Arm_front_upper_arm_", 5,5, 0,-90,90, true,0)
			create_bodypart(b, bodypart.front_arm_upper, -1, struct)
		break
		//	Front Arm Lower
		case 3:
			var struct = new create_bodypart_struct(s_zombie_front_arm_lower, "Walk_Front_Arm_front_lower_arm_", 5,5, 0,-45,45, true,2)
			create_bodypart(b, bodypart.front_arm_lower, -1, struct)
		break
		//	Front Arm Hand
		case 4:
			var struct = new create_bodypart_struct(s_zombie_front_arm_hand, "Walk_Front_Arm_front_hand_", 5,5, 0,-20,20, true,3)
			create_bodypart(b, bodypart.front_arm_hand, -1, struct)
		break
		//	Back Arm Upper
		case 5:
			var struct = new create_bodypart_struct(s_zombie_back_arm_upper, "Walk_Back_arm_back_upper_arm_", 5,5, 0,-90,90, true,0)
			create_bodypart(b, bodypart.back_arm_upper, -1, struct)
		break
		//	Back Arm Lower
		case 6:
			var struct = new create_bodypart_struct(s_zombie_back_arm_lower, "Walk_Back_arm_back_lower_arm_", 5,5, 0,-45,45, true,5)
			create_bodypart(b, bodypart.back_arm_lower, -1, struct)
		break
		//	Back Arm Hand
		case 7:
			var struct = new create_bodypart_struct(s_zombie_back_arm_hand, "Walk_Back_arm_back_hand_", 5,5, 0,-20,20, true,6)
			create_bodypart(b, bodypart.back_arm_hand, -1, struct)
		break
		//	Front Leg Upper
		case 8:
			var struct = new create_bodypart_struct(s_zombie_front_leg_upper, "Walk_Front_Leg_front_upper_leg_", 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.front_leg_upper, -1, struct)
		break
		//	Front Leg Lower
		case 9:
			var struct = new create_bodypart_struct(s_zombie_front_leg_lower, "Walk_Front_Leg_front_lower_leg_", 5,5, 0,-20,20, true,8)
			create_bodypart(b, bodypart.front_leg_lower, -1, struct)
		break
		//	Back Leg Upper
		case 10:
			var struct = new create_bodypart_struct(s_zombie_back_leg_upper, "Walk_Back_Leg_back_upper_leg_", 5,5, 0,-20,20, true,0)
			create_bodypart(b, bodypart.back_leg_upper, -1, struct)
		break
		//	Back Leg Lower
		case 11:
			var struct = new create_bodypart_struct(s_zombie_back_leg_lower, "Walk_Back_Leg_back_lower_leg_", 5,5, 0,-20,20, true,10)
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