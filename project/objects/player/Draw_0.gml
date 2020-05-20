if states != states.aim draw_self()

if states == states.aim and arm0 > -1 {
	
	draw_player_aiming()
	
	if X > -1 and Y > -1 {
		if bulletDrawTimer > 0 {
			bulletDrawTimer--
			if image_xscale > 0 var XX = x-13 else if image_xscale < 0 var XX = x+13
			var rotation = point_direction(XX,y-34,mouse_x,mouse_y)
			var muzzleX = lengthdir_x(64, rotation)
			var muzzleY = lengthdir_y(64, rotation)
			draw_set_color(c_yellow)
			draw_line(XX+muzzleX,y-34+muzzleY, X,Y)
		}
		else {
			X = -1
			Y = -1
			bulletDrawTimer = -1
		}
	}
	
}