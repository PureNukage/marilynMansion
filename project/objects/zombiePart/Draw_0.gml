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

if place_meeting(x, y, projectile) {
	var bullet = instance_place(x, y, projectile)
	if !bullet.hit {
		bullet.hit = true
		var xx = lengthdir_x(bullet.Speed*500, bullet.Direction)
		var yy = lengthdir_y(bullet.Speed*10, bullet.Direction)
		yy *= sign(yy)
	
		//draw_splat()
		var Splat = instance_create_layer(bullet.x, bullet.y, "Instances", splat)
		Splat.size = 0
	
		physics_apply_force(x,y, xx,yy)
	}
}

//draw_set_colour(c_red);
//physics_draw_debug();