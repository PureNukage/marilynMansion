if wind {
	draw_set_color(c_yellow)
	draw_circle(mouse_x,mouse_y,windRadius,true)	
}

if on {
	
	if instance_exists(zombie) with zombie {
		
		//	Draw hitbox for each bodypart
		for(var i=0;i<array_length(bodyparts);i++) {
			var struct = bodyparts[i][bodyparts_struct]
			var spriteString = struct.spriteBaseString + string(floor(image_index + 1))
			var genX = x - (sprite_get_xoffset(sprite_index)*image_xscale)
			var genY = y - sprite_get_yoffset(sprite_index)
			var spriteIndex = asset_get_index(spriteString)
			
			var oldOffsetX = sprite_get_xoffset(spriteIndex)
			var oldOffsetY = sprite_get_yoffset(spriteIndex)
			sprite_set_offset(spriteIndex,0,0)
			//draw_sprite_ext(spriteIndex,0,genX,genY,image_xscale,1,0,c_black,0.5)
			var _bbox_left = sprite_get_bbox_left(spriteIndex)*image_xscale var _bbox_right = sprite_get_bbox_right(spriteIndex)*image_xscale
			var _bbox_top = sprite_get_bbox_top(spriteIndex) var _bbox_bottom = sprite_get_bbox_bottom(spriteIndex)
			draw_set_color(c_red)
			draw_rectangle(genX+_bbox_left,genY+_bbox_top,genX+_bbox_right,genY+_bbox_bottom,true)
			
			sprite_set_offset(spriteIndex,oldOffsetX,oldOffsetY)
		}
		 
		//	Draw health
		draw_text_outlined(x,y-45,string(hp)+"/"+string(hpMax),c_white,c_black)
	}
	
	if instance_exists(class_ragdoll) with class_ragdoll {
		var originX = x - sprite_get_xoffset(sprite_index)
		var originY = y - sprite_get_yoffset(sprite_index)
		var Width = sprite_get_width(sprite_index)
		var Height = sprite_get_height(sprite_index)
		draw_set_color(c_yellow)
		draw_rectangle(originX,originY,originX+Width,originY+Height,true)
	}	
	
	if selectedBodypart > -1 {
		//draw_set_color(c_red)
		//draw_rectangle(selectedBodypart.bbox_left,selectedBodypart.bbox_top,selectedBodypart.bbox_right,selectedBodypart.bbox_bottom,true)
	
		//draw_set_color(c_yellow)
		//var Width = sprite_get_width(selectedBodypart.ragdoll.sprite_index)
		//var Height = sprite_get_height(selectedBodypart.ragdoll.sprite_index)
		//var X = selectedBodypart.ragdoll.x - (sprite_get_xoffset(selectedBodypart.ragdoll.sprite_index)*selectedBodypart.ragdoll.image_xscale)
		//var Y = selectedBodypart.ragdoll.y - sprite_get_yoffset(selectedBodypart.ragdoll.sprite_index)
		//draw_rectangle(X,Y, X+Width,Y+Height, true)
	}
	
	if phy_fix_on {
		if instance_exists(class_bodypart) with class_bodypart {
			if debug.selectedBodypart == id draw_set_color(c_green)	
			else draw_set_color(c_red)
			physics_draw_debug()
			
		}
	}
}