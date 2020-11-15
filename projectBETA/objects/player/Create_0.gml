event_inherited()

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
	
	//var endX = mouse_x
	//var endY = mouse_y
	
	reticle.radiusSpeed = 0.5
	
	var length = irandom_range(reticle.radiusMin,reticle.radius)
	var durection = irandom_range(0,359)
	
	var endX = mouse_x + lengthdir_x(length, durection)
	var endY = mouse_y + lengthdir_y(length, durection)
	
	var precision = 1
	var Direction = point_direction(startX,startY,endX,endY)
	
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
			
			//	Create bloodsplat particle
			var Particle = instance_create_layer(XX,YY,"Instances",particle)
			Particle.sprite_index = s_bloodsplat_0
			Particle.image_angle = point_direction(startX,startY, XX,YY)
			if x > array[0].x {
				Particle.image_xscale = -1
				Particle.image_angle += 180	
			}
			
			return array
		} else if instance_position(XX,YY, zombiePart) {
			loop = false
			var array = []
			array[0] = instance_position(XX,YY, zombiePart)
			array[1] = XX
			array[2] = YY
			
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			//	Create bloodsplat particle
			var Particle = instance_create_layer(XX,YY,"Instances",particle)
			Particle.sprite_index = s_bloodsplat_0
			Particle.image_angle = point_direction(startX,startY, XX,YY)
			if x > array[0].x {
				Particle.image_xscale = -1
				Particle.image_angle += 180	
			}
			
			return array
		
		} else if point_distance(XX,YY, endX,endY) < 2 {
			loop = false
			
			bulletArray[0] = XX
			bulletArray[1] = YY
			bulletArray[2] = startX
			bulletArray[3] = startY
			bulletArcDraw = 15
			
			//	Create bulletScorch particle
			var Particle = instance_create_layer(XX,YY,"Instances",particle)
			Particle.sprite_index = s_bulletScorch
			Particle.image_angle = irandom_range(0,359)
			
			return false
		} else {
			XX += lengthdir_x(precision, Direction)
			YY += lengthdir_y(precision, Direction)		
		}
		
		
	}
	
}

#region Reticle

	reticle = {
		radius: 16,
		radiusSpeed: 0.5,
		radiusMin: 8,
		radiusMax: 96,
		X: -1,
		Y: -1,
		XPrevious: -1,
		YPrevious: -1,
		
		firstCalculate: function() {
			var XX = other.x + (-15*other.image_xscale)
			var YY = other.y - 34
			var Direction = point_direction(XX,YY, mouse_x,mouse_y)
			XX += lengthdir_x(64, Direction)
			YY += lengthdir_y(64, Direction)
			
			var distance = point_distance(XX,YY, mouse_x,mouse_y)
			
			var max_distance = 800
			if distance < max_distance {
				var ratio = distance/max_distance
				var reticleRatio = radiusMax * ratio
				radius = reticleRatio
			}	
		},
		
		aimIncreasing: function() {
			var XX = other.x + (-15*other.image_xscale)
			var YY = other.y - 34
			var Direction = point_direction(XX,YY, mouse_x,mouse_y)
			XX += lengthdir_x(64, Direction)
			YY += lengthdir_y(64, Direction)
			
			radius -= radiusSpeed
			radiusSpeed += 0.10
			
			X = mouse_x
			Y = mouse_y
			if (X != XPrevious or Y != YPrevious) and (XPrevious != -1 and YPrevious != -1) {
				radius += abs((XPrevious - X)+(YPrevious - Y))/5
				XPrevious = X
				YPrevious = Y
			}
			if XPrevious == -1 or YPrevious == -1 {
				XPrevious = X
				YPrevious = Y
			}
			
			var distance = point_distance(XX,YY, mouse_x,mouse_y)
			
			var max_distance = 800
			if distance < max_distance {
				var ratio = distance/max_distance
				var reticleRatio = radiusMax * ratio
				var Radius = reticleRatio
				Radius = clamp(Radius,radiusMin,radiusMax)
				Radius = radiusMax
			} else Radius = radiusMax
			
			radius = clamp(radius,radiusMin,Radius)
		}
	}
	
#endregion