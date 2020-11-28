enum states {
	free,
	aim,
	looting
}

#macro bodyparts_enum 0
#macro bodyparts_id 1
#macro bodyparts_struct 2
#macro bodyparts_fixture 3

enum bodypart {
	torso,
	head,
	
	front_arm_upper,
	front_arm_lower,
	front_arm_hand,
	
	back_arm_upper,
	back_arm_lower,
	back_arm_hand,
	
	front_leg_upper,
	front_leg_lower,
	
	back_leg_upper,
	back_leg_lower,
}

enum item { 
	flashlight,
	gun,
	hand,
}