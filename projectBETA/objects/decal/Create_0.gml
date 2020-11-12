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
	
	//	Prep our crop surface
	var surfaceCrop = surface_create(spriteWidth,spriteHeight)
	surface_set_target(surfaceCrop)
	draw_clear_alpha(c_white, 0)
	surface_reset_target()
	
	var surface = surface_create(room_width,room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_white, 0)
	
	draw_sprite(oldSprite,instanceID.image_index,instanceID.x,instanceID.y)
	
	//gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
	var X = x
	var adjustX = 0
	//	This bodypart is flipped
	if instanceID.image_xscale == -1 {
		//	We're to the left of it
		if x < instanceID.x {
			adjustX = (instanceID.bbox_right - instanceID.bbox_left) - irandom_range(5,10)
		}
		else adjustX = -((instanceID.bbox_right - instanceID.bbox_left)  - irandom_range(5,10))
		X += adjustX
	}
	draw_sprite(sprite_index,0,X,y)
	//gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	var xs = instanceID.x - originX
	var ys = instanceID.y - originY
	surface_copy_part(surfaceCrop,0,0, surface,xs,ys, spriteWidth,spriteHeight)
		
	instanceID.sprite = sprite_create_from_surface(surfaceCrop,0,0,spriteWidth,spriteHeight,false,false,originX,originY)
		
	instanceID.sprite_index = instanceID.sprite
	
	surface_free(surface)
	surface_free(surfaceCrop)
	
	instance_destroy()
	
}