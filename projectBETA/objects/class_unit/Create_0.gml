input = -1
hspd = 0
xx = 0
yy = 0 
thrust = 0
hpMax = 3
hp = hpMax
maxSpeed = 0
onGround = true
groundY = y
states = -1

function setThrust(amount) {
	thrust = amount
	onGround = false
}

function applyThrust() {
	
	//	Going up
	if thrust > 0 {
		y -= thrust
		thrust--
	}
	//	Going down
	else {
		if !place_meeting(x,y-thrust,block) {
			y -= thrust
			thrust--
		}
		//	Landed
		else {
			onGround = true
			thrust = 0
			groundY = y
		}
	}
	
}

function create_bodypart_struct(_sprite, _fix_density, _fix_friction, _fix_angle, _min_angle, 
_max_angle, _angle, _bind) constructor {
	sprite = _sprite
	fix_density = _fix_density
	fix_friction = _fix_friction
	fix_angle = _fix_angle
	min_angle = _min_angle
	max_angle = _max_angle
	angle = _angle
	bind = _bind
}

function create_bodypart(index, type_enum, id, struct) {
	bodyparts[index][bodyparts_enum] = type_enum
	bodyparts[index][bodyparts_id] = -1
	bodyparts[index][bodyparts_struct] = struct
	bodyparts[index][bodyparts_fixture] = -1	
}