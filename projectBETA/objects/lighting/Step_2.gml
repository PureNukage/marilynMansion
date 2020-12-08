//	Draw lights onto surface
if !surface_exists(surface) {
	surface = create_surface(room_width,room_height)
	surface_set_target(surface)
	draw_set_color(c_black)
	draw_set_alpha(worldDark)
	draw_rectangle(0,0,room_width,room_height,false)
	surface_reset_target()
}

if surface_exists(surface) {
	surface_set_target(surface)
	
	draw_clear_alpha(c_white, 0)
	draw_set_color(c_black)
	draw_set_alpha(worldDark)
	if gunFired {
		draw_set_alpha(worldDark-0.3)
		gunFired = false
	}
	draw_rectangle(0,0,room_width,room_height,false)
	draw_rectangle(0,0,room_width,room_height,false)
	
	surface_reset_target()
	
	//var lightSurface = create_surface(room_width, room_height)
	//surface_set_target(lightSurface)
	
	//gpu_set_blendmode(bm_subtract)
	if instance_exists(class_light) with class_light {
		var lightID = id
		var lightSurface = create_surface(room_width, room_height)
		var shadowSurface = create_surface(room_width, room_height)
		surface_set_target(lightSurface)
		
		var scatterX = irandom_range(-5,5)
		var scatterY = irandom_range(-5,5)
		
		var lightX = x+scatterX
		var lightY = y+scatterY
		
		draw_sprite_ext(sprite_index,0,lightX,lightY,1.5,1.5,image_angle,c_black,brightness)
		
		if instance_exists(collisionFloor) with collisionFloor if !drawingCeiling {
			var floorID = id	
			if floorID.Floor > lightID.Floor {
				gpu_set_blendmode(bm_subtract)
				//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
				var Width = abs(bbox_right-bbox_left)
				var Height = abs(bbox_bottom-bbox_top)
				var Surface = create_surface(Width, Height)
				buffer_set_surface(floorSurfaceBuffer,Surface,0)
				draw_surface_ext(Surface,x,y,1,1,0,c_black,1)
				surface_free(Surface)
				gpu_set_blendmode(bm_normal)	
			}
		}
		
		surface_reset_target()
		surface_set_target(shadowSurface)
		
		//gpu_set_blendmode(bm_subtract)
		draw_set_alpha(1)
		draw_set_color(c_black)
		if instance_exists(shadowcast_wall) with shadowcast_wall {
			box_draw_shadow(lightX,lightY, 640)	
		}
		if instance_exists(shadowcast_wall) with shadowcast_wall {
			//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		}
		//debug.log(string(depth))
		if instance_exists(collisionFloor) with collisionFloor if !drawingCeiling {
			var floorID = id
			//debug.log("lightID.depth: "+string(lightID.depth))
			//debug.log("floorID.depth: "+string(floorID.depth))
			if floorID.depth < lightID.depth {
				gpu_set_blendmode(bm_subtract)
				//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
				var Width = abs(bbox_right-bbox_left)
				var Height = abs(bbox_bottom-bbox_top)
				var Surface = create_surface(Width, Height)
				buffer_set_surface(floorSurfaceBuffer,Surface,0)
				draw_surface_ext(Surface,x,y,1,1,0,c_black,1)
				surface_free(Surface)
				gpu_set_blendmode(bm_normal)
			}
			else {
				draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)	
			}
		}
		//gpu_set_blendmode(bm_normal)
		
		surface_reset_target()
		
		surface_set_target(lightSurface)
		gpu_set_blendmode(bm_subtract)
		draw_surface(shadowSurface,0,0)
		surface_reset_target()
		
		
		//surface_reset_target()
		//gpu_set_blendmode(bm_subtract)
		surface_set_target(lighting.surface)
		draw_surface(lightSurface,0,0)
		draw_surface(lightSurface,0,0)
		gpu_set_blendmode(bm_normal)
		surface_reset_target()
		
		//surface_save(shadowSurface, "shadowSurface"+string(lightID)+".png")
		//surface_save(lightSurface, "lightSurface"+string(lightID)+".png")
		//surface_save(shadowSurface,"shadowSurface.png")
		
		surface_free(lightSurface)
		surface_free(shadowSurface)
		
		//draw_set_alpha(brightness)
		//draw_circle(x+scatterX,y+scatterY,128,false)
	}
	
	//draw_set_alpha(1)
	//gpu_set_blendmode(bm_subtract)
	//if instance_exists(class_light) with class_light {
	//	if instance_exists(shadowcast_wall) with shadowcast_wall {
	//		box_draw_shadow(other.x,other.y, 640)	
	//	}
	//}
	//gpu_set_blendmode(bm_normal)
	
	//surface_reset_target()
	surface_set_target(surface)
	
	//surface_save(lightSurface,"lightSurface.png")
	
	gpu_set_blendmode(bm_subtract)
	
	//draw_surface(lightSurface,0,0)
	//draw_surface(lightSurface,0,0)
	
	//	Flashlight
	if instance_exists(player) {
		if player.flashlightOn and player.inventory[player.inventoryIndex].item == item.flashlight {
			var rawDirection = point_direction(player.x + (player.arm0_offsetX*player.image_xscale),player.y+player.arm0_offsetY, player.x + (-3 * player.image_xscale),player.y-16)
			var rawDist = point_distance(player.x + (player.arm0_offsetX*player.image_xscale),player.y+player.arm0_offsetY, player.x + (-3 * player.image_xscale),player.y-16)
			if player.image_xscale rawDirection += player.gunRotation
			else rawDirection += player.gunRotation - 180
			var X = player.x + (player.arm0_offsetX*player.image_xscale) + lengthdir_x(rawDist, rawDirection)
			var Y = player.y+player.arm0_offsetY + lengthdir_y(rawDist, rawDirection)
			draw_sprite_ext(s_light_flashlight,0,X,Y,1,1,player.gunRotation,c_black,0.5)	
			
			//	Lighten the players body sprite
			var Scale = 0.25
			X += lengthdir_x(8, player.gunRotation)
			Y += lengthdir_y(8, player.gunRotation)
			//draw_sprite_ext(player.sprite_index,player.image_index,player.x,player.y,player.image_xscale,player.image_yscale,player.image_angle,c_black,0.5)
			draw_sprite_ext(s_light_gradient,0,X,Y,Scale,Scale,0,c_black,0.5)
			
			//debug.log("FLASHLIGHT DEBUG player.gunRotation: "+string(player.gunRotation))
		}
	}
	
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	////	Shadowcasting
	var surfaceShadowcast = create_surface(room_width,room_height)
	surface_set_target(surfaceShadowcast)
	
	draw_set_color(c_black)
	draw_set_alpha(1)
	if instance_exists(shadowcast_wall) with shadowcast_wall if draw {
		box_draw_shadow(player.x,player.y-32, 640)	
	}

	gpu_set_blendmode(bm_subtract)
	draw_set_color(c_white)
	if instance_exists(shadowcast_wall) with shadowcast_wall {
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	}
	if instance_exists(collisionFloor) with collisionFloor if !drawingCeiling {
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	}
	
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	surface_set_target(surface)
	draw_surface(surfaceShadowcast,0,0)
	surface_reset_target()
	
	surface_free(surfaceShadowcast)
	
	draw_set_alpha(1)
	
	//surface_reset_target()
}