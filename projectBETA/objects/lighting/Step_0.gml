if refreshLights {
	var lightID = list[| lightsIndex]
	lightID.create_light()
	lightsIndex++
	if lightsIndex >= ds_list_size(list) {
		lightsIndex = 0
		refreshLights = false
	}
}