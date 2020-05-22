x -= 1

image_xscale = -1

if x <= 900 {
	var ragDoll = instance_create_layer(x,y,"Instances",zombieRagdoll)
	ragDoll.spawnRagdoll()
	instance_destroy()
}
