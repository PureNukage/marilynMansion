depth = -2

ID = -1

function applyDecal(instanceID) {
	
	var oldSprite = instanceID.sprite_index
	
	var spriteWidth = sprite_get_width(oldSprite)
	var spriteHeight = sprite_get_height(oldSprite)
	
	var originX = sprite_get_xoffset(oldSprite)
	var originY = sprite_get_yoffset(oldSprite)
	
	//	Prep our crop surface
	var surfaceCrop = create_surface(spriteWidth,spriteHeight)
	var bloodSurfaceRaw = create_surface(room_width,room_height)
	var surfaceFinal = create_surface(spriteWidth,spriteHeight)
	
	surface_set_target(bloodSurfaceRaw)
	draw_sprite(sprite_index,0,x,y)
	surface_reset_target()
	
	var X = instanceID.x - originX
	var Y = instanceID.y - originY
	//surface_copy_part(bloodSurfaceSprite,0,0, bloodSurfaceRaw, X,Y, spriteWidth,spriteHeight)
	
	var bloodSprite = sprite_create_from_surface(bloodSurfaceRaw, X,Y, spriteWidth,spriteHeight, false,false, originX,originY)
	
	var surface = create_surface(room_width,room_height)
	surface_set_target(surface)
	
	//draw_sprite_ext(oldSprite,instanceID.image_index,instanceID.x,instanceID.y,instanceID.image_xscale,1,instanceID.image_angle,c_white,1)
	draw_sprite(oldSprite,instanceID.image_index,instanceID.x,instanceID.y)
	
	gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
	draw_sprite_ext(bloodSprite,0, instanceID.x,instanceID.y, instanceID.image_xscale,1,instanceID.image_angle,c_white,1)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	var xs = instanceID.x - originX
	var ys = instanceID.y - originY
	
	surface_copy_part(surfaceCrop,0,0, surface,xs,ys, spriteWidth,spriteHeight)
	
	surface_set_target(surfaceFinal)
	//draw_sprite_ext(oldSprite,instanceID.image_index,originX,originY,instanceID.image_xscale,1,instanceID.image_angle,c_white,1)
	draw_sprite(oldSprite,0,originX,originY)
	draw_surface(surfaceCrop,0,0)
	surface_reset_target()
		
	instanceID.sprite = sprite_create_from_surface(surfaceFinal,0,0,spriteWidth,spriteHeight,false,false,originX,originY)
	
	var Sprite = sprite_create_from_surface(surfaceFinal,0,0,spriteWidth,spriteHeight,false,false,originX,originY)
	var Surface = create_surface(spriteWidth,spriteHeight)
	//surface_set_target(Surface)
	//draw_sprite_ext(Sprite,0,originX,originY,instanceID.image_xscale,1,360-instanceID.image_angle,c_white,1)
	//surface_reset_target()
	
	//instanceID.sprite = sprite_create_from_surface(Surface,0,0,spriteWidth,spriteHeight,false,false,originX,originY)
		
	instanceID.sprite_index = instanceID.sprite
	
	sprite_save(instanceID.sprite_index,0,"decal.png")
	
	surface_save(surfaceCrop,"decalSurfaceCrop.png")
	surface_save(Surface,"decalSurface.png")
	
	surface_free(surface)
	surface_free(surfaceCrop)
	surface_free(bloodSurfaceRaw)
	surface_free(surfaceFinal)
	surface_free(Surface)
	
	sprite_delete(Sprite)
	
	sprite_save(bloodSprite,0,"decalBloodSprite.png")
	
	sprite_delete(bloodSprite)
	
	instance_destroy()
	
}