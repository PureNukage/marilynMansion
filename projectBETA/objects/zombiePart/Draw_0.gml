draw_sprite_ext(spriteBase,0,x,y,image_xscale,1,image_angle,c_white,1)
draw_sprite_ext(sprite_index,0,x,y,image_xscale,1,image_angle,c_white,1)

if debug.on {
	draw_set_color(c_red)
	physics_draw_debug()
}