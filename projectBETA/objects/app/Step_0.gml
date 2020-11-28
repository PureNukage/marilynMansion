if cameraRefresh > -1 {
	cameraRefresh++
	if cameraRefresh >= 1 {
		game.cameraSetup()
		cameraRefresh = -1
	}
}

if layer_exists("window") layer_set_visible("window",false)