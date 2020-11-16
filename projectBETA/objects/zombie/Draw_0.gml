draw_self()

//	Blood decal surface
if surface_exists(bloodSurface) {
	var surface = surface_create(room_width,room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_white, 0)
	
	draw_self()
	gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
	var X = x - sprite_get_xoffset(sprite_index)
	var Y = y - sprite_get_yoffset(sprite_index)
	draw_surface(bloodSurface, X,Y)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	draw_surface(surface,0,0)
	
	surface_free(surface)
}
else {
	bloodSurface = surface_create(sprite_get_width(sprite_index),sprite_get_height(sprite_index))
	surface_set_target(bloodSurface)
	draw_clear_alpha(c_white, 0)
	surface_reset_target()	
}