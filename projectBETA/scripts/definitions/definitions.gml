enum states {
	free,
	aim,
	reloading,
	looting,
	walk
}

#macro animation_end (image_index > image_number - 1)

#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)

#macro bodyparts_enum 0
#macro bodyparts_id 1
#macro bodyparts_struct 2
#macro bodyparts_fixture 3
#macro bodyparts_sprites 4

#macro floor_floor 0
#macro floor_ceiling 1
#macro floor_ceiling_y 2

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