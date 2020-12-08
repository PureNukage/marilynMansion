on = false

depth = -2

function log(String) {
	
	var Object = string_upper(object_get_name(other.object_index))
	
	var Time = "[" + string(time.stream) + "]"
	
	show_debug_message(Time + " " + Object + + " " + String)
	
}

////	test
var surface = create_surface(500, 500)
surface_set_target(surface)

gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_rectangle(0,0, 500,00, false)
gpu_set_blendmode(bm_normal)
surface_reset_target()

surface_save(surface,"test.png")
surface_free(surface)