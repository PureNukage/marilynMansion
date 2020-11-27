if input.spawnZombie and input.mouseLeftPress {
	var Zombie = instance_create_layer(mouse_x,mouse_y,"Instances",zombie)
	Zombie.die()
	
}