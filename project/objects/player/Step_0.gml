key_left = keyboard_check(ord("A"))
key_right = keyboard_check(ord("D"))

mouse_right = mouse_check_button(mb_right)

mouse_left_press = mouse_check_button_pressed(mb_left)

hspd = (key_right - key_left)*movespeed

if hspd != 0 and states != states.aim {
	if states != states.walk states = states.walk
}

if states == states.walk {
	x += hspd
	if hspd != 0 {
		image_speed = 1
		sprite_index = s_person_walk
	} else {
		image_speed = 0
		sprite_index = s_player_whole
	}
	if hspd > 0 image_xscale = 1
	if hspd < 0 image_xscale = -1
} else {
	if states != states.aim {
		hspd = 0
		sprite_index = s_player_whole		
	}
}

if mouse_right {
	if states != states.aim {
		hspd = 0
		states = states.aim
		sprite_index = s_player_aim_body
		arm0 = s_player_aim_right_arm
		arm1 = s_player_aim_left_arm
	}
} else {
	if states == states.aim {
		states = states.idle	
		sprite_index = s_player_whole
	}
}

if keyboard_check_pressed(vk_space) game_restart()