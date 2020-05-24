depth = -2

ID = -1

function applyDecal(instanceID) {
	
	var oldSprite = instanceID.sprite
	
	var spriteWidth = sprite_get_width(oldSprite)
	var spriteHeight = sprite_get_height(oldSprite)
	
	var originX = sprite_get_xoffset(oldSprite)
	var originY = sprite_get_yoffset(oldSprite)
	
	var decalOffsetX = instanceID.x - x
	var decalOffsetY = y - instanceID.y
	
	var surface = surface_create(spriteWidth,spriteHeight)
	
	surface_set_target(surface)
	draw_clear_alpha(c_white, 0)
	
	draw_sprite(oldSprite,instanceID.image_index,originX,originY)
	
	gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
	draw_sprite(sprite_index,0,originX+decalOffsetX,originY+decalOffsetY)
	gpu_set_blendmode(bm_normal)
		
	instanceID.sprite = sprite_create_from_surface(surface,0,0,spriteWidth,spriteHeight,false,false,originX,originY)
		
	instanceID.sprite_index = instanceID.sprite
	
	surface_reset_target()
	surface_free(surface)	
	
	instance_destroy()
	
}