event_inherited()

on = false
light = -1

function interact(on_or_off) {
	//	On
	if on_or_off {
		light = instance_create_layer(x,y,"Instances",class_light)
		light.depth = depth
		light.Floor = Floor
		sprite_index = s_candle
		image_index = 0
	}
	//	Off
	else {
		if light > -1 and instance_exists(light) instance_destroy(light)
		light = -1
		sprite_index = s_candle_off
		image_index = 0
	}
	on = on_or_off
}

interact(false)