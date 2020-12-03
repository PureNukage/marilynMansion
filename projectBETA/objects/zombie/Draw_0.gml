draw_self()

////	Blood decal surface
//if surface_exists(bloodSurface) {
//	var surface = create_surface(sprite_get_width(sprite_index),sprite_get_height(sprite_index))
//	surface_set_target(surface)
	
//	var Sprite = sprite_create_from_surface(bloodSurface,0,0,sprite_get_width(sprite_index),sprite_get_height(sprite_index),
//	false,false,sprite_get_width(sprite_index)/2,sprite_get_height(sprite_index)/2)
	
//	//draw_sprite(sprite_index,image_index,sprite_get_xoffset(sprite_index),sprite_get_yoffset(sprite_index))
//	draw_sprite_ext(sprite_index,image_index,sprite_get_xoffset(sprite_index),sprite_get_yoffset(sprite_index),image_xscale,1,0,c_white,1)
//	gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
//	//draw_surface(bloodSurface, 0,0)
//	draw_sprite_ext(Sprite,0,sprite_get_width(sprite_index)/2,sprite_get_height(sprite_index)/2,1,1,0,c_white,1)
//	gpu_set_blendmode(bm_normal)
	
//	surface_reset_target()
	
//	draw_surface(surface,x-sprite_get_xoffset(sprite_index),y-sprite_get_yoffset(sprite_index))
	
//	surface_save(surface,"surface.png")
	
//	sprite_delete(Sprite)
//	surface_free(surface)
//}
//else {
//	bloodSurface = surface_create(sprite_get_width(sprite_index),sprite_get_height(sprite_index))
//	surface_set_target(bloodSurface)
//	draw_clear_alpha(c_white, 0)
//	surface_reset_target()	
//}