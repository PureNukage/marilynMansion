depth = 505
Floor = 0
light = -1

function spawnlight() {
	if light > -1 and instance_exists(light) {
		lighting.remove_light(ds_list_find_index(lighting.list,light))
		instance_destroy(light)	
	}
	light = instance_create_layer(x,y,"Instances",class_light)
	light.depth = depth
	light.Floor = Floor	
	light.create_light()
	lighting.add_light(light)
}

spawnlight()