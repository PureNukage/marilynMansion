if instance_place(x,y,projectile) {
	var bullet = instance_place(x,y, projectile)
	var Splat = instance_create_layer(bullet.x, bullet.y, "Instances", splat)
	Splat.size = 3
	instance_destroy()	
}