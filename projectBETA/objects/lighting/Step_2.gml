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
	
	gpu_set_blendmode(bm_subtract)
	if instance_exists(class_light) with class_light {
		var scatterX = irandom_range(-5,5)
		var scatterY = irandom_range(-5,5)
		draw_sprite_ext(sprite_index,0,x+scatterX,y+scatterY,1.5,1.5,image_angle,c_black,brightness)
		//draw_set_alpha(brightness)
		//draw_circle(x+scatterX,y+scatterY,128,false)
	}
	
	//	Flashlight
	if instance_exists(player) {
		if player.flashlightOn and player.inventory[player.inventoryIndex].item == item.flashlight {
			var rawDirection = point_direction(player.x + (player.arm0_offsetX*player.image_xscale),player.y+player.arm0_offsetY, player.x + (-3 * player.image_xscale),player.y-33)
			var rawDist = point_distance(player.x + (player.arm0_offsetX*player.image_xscale),player.y+player.arm0_offsetY, player.x + (-3 * player.image_xscale),player.y-33)
			if player.image_xscale rawDirection += player.gunRotation
			else rawDirection += player.gunRotation - 180
			var X = player.x + (player.arm0_offsetX*player.image_xscale) + lengthdir_x(rawDist, rawDirection)
			var Y = player.y+player.arm0_offsetY + lengthdir_y(rawDist, rawDirection)
			draw_sprite_ext(s_light_flashlight,0,X,Y,1,1,player.gunRotation,c_black,0.5)	
			//debug.log("FLASHLIGHT DEBUG player.gunRotation: "+string(player.gunRotation))
		}
	}
	
	gpu_set_blendmode(bm_normal)
	
	draw_set_alpha(1)
	
	surface_reset_target()
}