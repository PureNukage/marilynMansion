var rotation = point_direction(x,y-20,mouse_x,mouse_y)

//	Aiming to the left
if mouse_x < x {
	var yscale = -1 
} 
//	Aiming to the right
else {
	var yscale = 1
}

//	Aiming to the right
if yscale > 0 {
	draw_sprite_ext(arm1,0,x+10,y-24,1,yscale,rotation+rotation,c_white,1)
	draw_self()
	draw_sprite_ext(arm0,0,x-11,y-23,1,yscale,rotation,c_white,1)	
}

else {
	if rotation < 180 var arm_rotation = rotation-rotation/5
	else var arm_rotation = rotation
	draw_sprite_ext(arm1,0,x-10,y-24,1,yscale,arm_rotation,c_white,1)
	draw_self()
	draw_sprite_ext(arm0,0,x+11,y-23,1,yscale,rotation,c_white,1)
}

if image_xscale != yscale image_xscale = yscale

if mouse_left_press {
	var muzzleX = lengthdir_x(64, rotation)
	var muzzleY = lengthdir_y(64, rotation)
	if image_xscale > 0 var XX = x-13 else if image_xscale < 0 var XX = x+13
	var array = bulletFire(mouse_x,mouse_y,XX+muzzleX,y-34+muzzleY,zombieDamageParent,1)
	if array[2] > -1 {
		if array[2].object_index == zombie {
			array[2].dead = 1
		}	
	}
	
	X = array[0]
	Y = array[1]
	bulletDrawTimer = 15
	//var bullet = instance_create_layer(x+10+muzzleX,y-24+muzzleY,"Instances",projectile)
	//bullet.Speed = 50
	//bullet.Direction = point_direction(x,y,mouse_x,mouse_y)
	arm0 = s_muzzleFlash
} else {
	if arm0 != s_player_aim_right_arm arm0 = s_player_aim_right_arm	
}

////	DEBUG
var xx = x + 64
var yy = y - 64
//draw_text(xx,yy,"rotation: "+string(rotation)) yy += 15