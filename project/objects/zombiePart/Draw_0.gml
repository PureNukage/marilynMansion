//draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_aqua,1)
draw_self()

with player {
	if sprite_index == s_person_walk {
		if animation_end {
			if place_meeting(x,y,zombiePart) {
				var part = place_meeting(x,y,zombiePart)
				with other physics_apply_force(x,y, other.hspd*100, 0)
			}
		}
	}
}

//draw_set_colour(c_red);
//physics_draw_debug();