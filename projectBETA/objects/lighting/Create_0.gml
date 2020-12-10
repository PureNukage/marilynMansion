surface = create_surface(room_width,room_height)

gunFired = false

worldDark = 1
//worldDark = .5

surface_set_target(surface)
draw_set_color(c_black)
draw_set_alpha(worldDark)
draw_rectangle(0,0,room_width,room_height,false)
surface_reset_target()

draw_set_alpha(1)

refreshLights = false
lightsIndex = 0

list = ds_list_create()

function add_light(ID) {
	ds_list_add(list, ID)
}

function remove_light(index) {
	ds_list_delete(list, index)	
}