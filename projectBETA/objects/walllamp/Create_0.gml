depth = 505
Floor = 0
light = -1

function spawnlight() {
	if light > -1 and instance_exists(light) instance_destroy(light)
	light = instance_create_layer(x,y,"Instances",class_light)
	light.depth = depth
	light.Floor = Floor	
}

spawnlight()