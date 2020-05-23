input = instance_create_layer(0,0,"Instances",playerInput)

hspd = 0
maxSpeed = 5

arm0 = s_player_arm_aim
arm0_offsetX = -12
arm0_offsetY = -22

arm1 = s_player_arm_support
arm1_offsetX = 12
arm1_offsetY = -23

gunRotation = -1

bulletArcDraw = -1
bulletArray = []

xx = 0

states = states.free

function fireGun() {
	
	var startX = x + (-15 * image_xscale)
	var startY = y - 34
	
	var endX = mouse_x
	var endY = mouse_y
	
	var precision = 1
	var Direction = point_direction(startX,startY,mouse_x,mouse_y)
	
	var XX = startX
	var YY = startY
	
	startX += lengthdir_x(64, Direction)
	startY += lengthdir_y(64, Direction)
	
	var loop = true
	while loop {
		
		if instance_position(XX,YY, zombie) {
			loop = false
			var array = []
			array[0] = instance_position(XX,YY, zombie)
			array[1] = XX
			array[2] = YY
			
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			return array
		} else if point_distance(XX,YY, endX,endY) < 2 {
			loop = false
			
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			return false
		} else {
			XX += lengthdir_x(precision, Direction)
			YY += lengthdir_y(precision, Direction)		
		}
		
		
	}
	
}