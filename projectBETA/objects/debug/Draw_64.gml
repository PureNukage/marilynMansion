var xx = 15
var yy = 15

var e = []
e[states.free] = "free"
e[states.aim] = "aim"
e[states.looting] = "looting"

draw_set_font(fnt_debug)

if on {
	draw_text_outlined(xx,yy,"player.gunRotation: "+string(player.gunRotation),c_white,c_black) yy += 15
	draw_text_outlined(xx,yy,"player.depth: "+string(player.depth),c_white,c_black) yy += 15
	draw_text_outlined(xx,yy,"player.Floor: "+string(player.Floor),c_white,c_black) yy += 15
	//draw_text_outlined(xx,yy,"player.depth: "+string(player.depth),c_white,c_black) yy += 15
	//draw_text_outlined(xx,yy, "player.y: "+string(player.y),c_white,c_black) yy += 15
	//draw_text_outlined(xx,yy, "game.states: " + e[game.states], c_white, c_black) yy += 15
	//draw_text_outlined(xx,yy, "game.camera.x: "+string(camera_get_view_x(game.camera)),c_white,c_black) yy += 15
	//draw_text_outlined(xx,yy, "game.camera.y: "+string(camera_get_view_y(game.camera)),c_white,c_black) yy += 15
}

draw_reset()