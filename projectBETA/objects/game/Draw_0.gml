var ID = instance_position(mouse_x,mouse_y,class_grab)
if ID > -1 and states == states.looting {
	window_set_cursor(cr_none)
	draw_sprite_ext(s_hand,0,mouse_x,mouse_y,.5,.5,0,c_white,1)	
}