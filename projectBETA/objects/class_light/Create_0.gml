brightness = 1
scale = 1.25
Floor = 0
lightSprite = -1

function create_light() {
	
	if lightSprite > -1 and sprite_exists(lightSprite) sprite_delete(lightSprite)

	//	Create surfaces
	var surfaceRaw = create_surface(room_width, room_height)
	var surfaceShadowRaw = create_surface(room_width, room_height)
	var surfaceCrop = create_surface(sprite_get_width(sprite_index)*scale, sprite_get_height(sprite_index)*scale)

	var lightID = id

	var lightX = x
	var lightY = y
	
	//	Draw the light
	surface_set_target(surfaceRaw)
	
	draw_sprite_ext(sprite_index,image_index,lightX,lightY,scale,scale,image_angle,c_black,1)
	surface_reset_target()
	
	draw_set_alpha(1)
	
	
	////	Lets draw the shadow surface now
	surface_set_target(surfaceShadowRaw)

	//	Floor shadow
	if instance_exists(collisionFloor) with collisionFloor if !drawingCeiling {
		var floorID = id
		if floorID.Floor > lightID.Floor {
			var Width = abs(bbox_right-bbox_left)
			var Height = abs(bbox_bottom-bbox_top)
			var Surface = surface_create(Width, Height)
			buffer_set_surface(floorSurfaceBuffer,Surface,0)
			draw_surface_ext(Surface,x,y,1,1,0,c_black,1)
			surface_free(Surface)
		}
	}
	
	//	Shadowcasting
	if instance_exists(shadowcast_wall) with shadowcast_wall {
		box_draw_shadow(lightX,lightY, 640)	
	}
	
	////	Removing some shadows if this light is on its own floor
	gpu_set_blendmode(bm_subtract)
	if instance_exists(collisionFloor) with collisionFloor if !drawingCeiling {
		var floorID = id
		if floorID.depth < lightID.depth and floorID.Floor == lightID.Floor {
			var Width = abs(bbox_right-bbox_left)
			var Height = abs(bbox_bottom-bbox_top)
			var Surface = surface_create(Width, Height)
			buffer_set_surface(floorSurfaceBuffer,Surface,0)
			draw_surface_ext(Surface,x,y,1,1,0,c_black,1)
			surface_free(Surface)
		}
	}
	//if instance_exists(shadowcast_wall) with shadowcast_wall {
	//	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	//}
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	//	Subtract the shadows from the light source
	surface_set_target(surfaceRaw)
	gpu_set_blendmode(bm_subtract)
	draw_surface(surfaceShadowRaw,0,0)
	gpu_set_blendmode(bm_normal)
	surface_reset_target()

	var X = x - (sprite_get_xoffset(sprite_index) * scale)
	var Y = y - (sprite_get_yoffset(sprite_index) * scale)
	var WWidth = sprite_get_width(sprite_index) * scale
	var HHeight = sprite_get_height(sprite_index) * scale
	surface_copy_part(surfaceCrop,0,0,surfaceRaw,X,Y,WWidth,HHeight)

	lightSprite = sprite_create_from_surface(surfaceCrop,0,0,WWidth,HHeight,false,false,sprite_get_xoffset(sprite_index)*scale,sprite_get_yoffset(sprite_index)*scale)
	
	surface_free(surfaceRaw)
	surface_free(surfaceShadowRaw)
	surface_free(surfaceCrop)
}