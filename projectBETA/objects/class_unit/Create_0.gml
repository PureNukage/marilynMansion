input = -1
hspd = 0
xx = 0
yy = 0 
thrust = 0
hpMax = 3
hp = hpMax
maxSpeed = 0
onGround = true
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
		}
	}
	
}