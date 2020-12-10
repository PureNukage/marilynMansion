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
	
	gpu_set_blendmode(bm_subtract)
	if instance_exists(class_light) with class_light if lightSprite > -1 {	
		draw_sprite_ext(lightSprite,0,x,y,1,1,0,c_black,brightness)
	}
	
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
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom-1,false)
	}
	
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	surface_set_target(surface)
	draw_surface(surfaceShadowcast,0,0)
	surface_reset_target()
	
	surface_free(surfaceShadowcast)
	
	draw_set_alpha(1)
}