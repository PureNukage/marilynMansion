//	debug wind collision
if debug.wind and point_in_circle(x,y, mouse_x,mouse_y, debug.windRadius) {
	var Force = 100
	var xForce = (x - mouse_x) * Force
	var yForce = (y - mouse_y) * Force
	physics_apply_force(mouse_x,mouse_y, xForce,yForce)
}