if cameraRefresh > -1 {
	cameraRefresh++
	if cameraRefresh >= 1 {
		game.cameraSetup()
		cameraRefresh = -1
	}
}