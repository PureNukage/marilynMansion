draw_self()

//	Blood surface
if !surface_exists(bloodSurface) {
	bloodSurface = create_surface(sprite_get_width(sprite_index),sprite_get_height(sprite_index))	
}
else {
	draw_surface(bloodSurface,x-sprite_get_xoffset(sprite_index),y-sprite_get_yoffset(sprite_index))	
}