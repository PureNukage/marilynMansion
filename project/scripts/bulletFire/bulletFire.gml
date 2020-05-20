///@param goalX
///@param goalY
///@param startX
///@param startY
///@param object
///@param precision

var goalX = argument[0]
var goalY = argument[1]
var startX = argument[2]
var startY = argument[3]
var object = argument[4]
var precision = argument[5]

var Direction = point_direction(startX,startY, goalX,goalY)

var X = startX
var Y = startY

var loop = true
while loop {
	
	//	Loop finished
	if point_distance(X,Y, goalX,goalY) < 1 {
		var array = []
		array[0] = X
		array[1] = Y
		array[2] = -1
		return array
		loop = false
	} else if instance_position(X,Y, object) {
		array[0] = X
		array[1] = Y
		array[2] = instance_position(X,Y, object)
		return array
		loop = false
	}
	
	else {
		X += lengthdir_x(precision, Direction)
		Y += lengthdir_y(precision, Direction)
	}
	
}