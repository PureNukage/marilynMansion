x -= 1

image_xscale = -1

if place_meeting(x,y,projectile) and dead == 0 {
	var ragdoll = instance_create_layer(x,y,"Instances",zombieRagdoll)
	instance_destroy()
}
