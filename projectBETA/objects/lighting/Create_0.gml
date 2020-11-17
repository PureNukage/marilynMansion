surface = create_surface(room_width,room_height)

gunFired = false

worldDark = 0.99
worldDark = 0.8

surface_set_target(surface)
draw_set_color(c_black)
draw_set_alpha(worldDark)
draw_rectangle(0,0,room_width,room_height,false)
surface_reset_target()

draw_set_alpha(1)