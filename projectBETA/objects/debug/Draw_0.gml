if on {
	
	var array = []
	array[states.free] = "free"
	array[states.aim] = "aim"
	
	draw_set_color(c_yellow)
	
	var gameScale = 0.1
	if instance_exists(game) draw_sprite_ext(s_debug_camera,0,game.x,game.y,gameScale,gameScale,0,c_white,1)
	
	if instance_exists(zombie) with zombie {
		draw_set_color(c_yellow)
		var x1 = x-sprite_get_xoffset(sprite_index)
		var y1 = y-sprite_get_yoffset(sprite_index)
		draw_rectangle(x1,y1, x1+sprite_get_width(sprite_index),y1+sprite_get_height(sprite_index),true)
		
		//	Draw hitbox for each bodypart
		for(var i=0;i<array_length(bodyparts);i++) {
			var struct = bodyparts[i][bodyparts_struct]
			var firstString = string_copy(sprite_get_name(sprite_index),string_pos("_",sprite_get_name(sprite_index))+1,string_length(sprite_get_name(sprite_index))-string_pos("_",sprite_get_name(sprite_index))+1 )
			var spriteString = firstString + struct.sprite + string(floor(image_index)+1)
			var sprite = asset_get_index(spriteString)
			
			var genX = x + (-sprite_get_xoffset(sprite_index)*image_xscale)
			var genY = y - sprite_get_yoffset(sprite_index)
			
			var oldOffsetX = sprite_get_xoffset(sprite)
			var oldOffsetY = sprite_get_yoffset(sprite)
			
			sprite_set_offset(sprite,0,0)
			
			var _bbox_left = sprite_get_bbox_left(sprite)*image_xscale var _bbox_right = sprite_get_bbox_right(sprite)*image_xscale
			var _bbox_top = sprite_get_bbox_top(sprite) var _bbox_bottom = sprite_get_bbox_bottom(sprite)
			
			draw_set_color(c_red)
			draw_rectangle(genX+_bbox_left,genY+_bbox_top,genX+_bbox_right,genY+_bbox_bottom,true)
			
			sprite_set_offset(sprite,oldOffsetX,oldOffsetY)
		}
	}
	
	if instance_exists(player) with player {
		
		var xx = x+64
		var yy = y-64
		
		
		//draw_text(xx,yy, "state: " + array[states])	yy += 15
		//draw_text(xx,yy, "hspd: " + string(hspd))	yy += 15
		//draw_text(xx,yy, "gunRotation: "+string(gunRotation))	yy += 15
		
		
		
		
	}
	
	if instance_exists(zombieRagdoll) with zombieRagdoll {
		
		var xx = x+64
		var yy = y-64
		
		//draw_text(xx,yy, "physics: " + string(phy_active))
		
		//draw_text(xx,yy, "image_xscale: " + string(image_xscale))
		
	}
	
	draw_set_color(c_red)
	with block {
		physics_draw_debug()
	}
	
	
	
	
}