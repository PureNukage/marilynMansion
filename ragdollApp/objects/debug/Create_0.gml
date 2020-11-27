on = false

selectedBodypart = -1

physics_on = false
phy_fix_on = false

function log(String) {
	
	var Time = "[" + string(time.stream) + "] "
	
	var Object = string_upper(object_get_name(other.object_index))
	
	var fullMessage = Time + Object + " " + String
	
	show_debug_message(fullMessage)
}

function button(x,y,width,height,text) {
	
	var mouseover = false
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_set_color(c_black)
	draw_roundrect(x-2,y-2,x+width+2,y+height+2,false)
	
	if point_in_rectangle(mouse_gui_x,mouse_gui_y,x,y,x+width,y+height) {
		draw_set_color(c_ltgray)
		mouseover = true
	}
	else {
		draw_set_color(c_gray)
		mouseover = false	
	}
	draw_roundrect(x,y,x+width,y+height,false)
	
	draw_set_color(c_black)
	draw_text(x+width/2,y+height/2,text)
	
	return mouseover
	
}