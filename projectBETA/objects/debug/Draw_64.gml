var xx = 15
var yy = 15

var e = []
e[states.free] = "free"
e[states.aim] = "aim"
e[states.looting] = "looting"

if on {
	draw_text_outlined(xx,yy,"player.depth: "+string(player.depth),c_white,c_black) yy += 15
	draw_text_outlined(xx,yy, "player.y: "+string(player.y),c_white,c_black) yy += 15
	draw_text_outlined(xx,yy, "game.states: " + e[game.states], c_white, c_black) yy += 15
}