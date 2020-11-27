if on {
	
	if selectedBodypart > -1 {
		//draw_set_color(c_red)
		//draw_rectangle(selectedBodypart.bbox_left,selectedBodypart.bbox_top,selectedBodypart.bbox_right,selectedBodypart.bbox_bottom,true)
	
		draw_set_color(c_yellow)
		var Width = sprite_get_width(selectedBodypart.ragdoll.sprite_index)
		var Height = sprite_get_height(selectedBodypart.ragdoll.sprite_index)
		var X = selectedBodypart.ragdoll.x - (sprite_get_xoffset(selectedBodypart.ragdoll.sprite_index)*selectedBodypart.ragdoll.image_xscale)
		var Y = selectedBodypart.ragdoll.y - sprite_get_yoffset(selectedBodypart.ragdoll.sprite_index)
		draw_rectangle(X,Y, X+Width,Y+Height, true)
	}
	
	if phy_fix_on {
		if instance_exists(class_bodypart) with class_bodypart {
			if debug.selectedBodypart == id draw_set_color(c_green)	
			else draw_set_color(c_red)
			physics_draw_debug()
			
		}
	}
}