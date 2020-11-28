if !onGround {
	applyThrust()
}

if dead {
	if !onGround {
		if image_angle != rotateAngle
		image_angle += sign(rotateAngle) * thrust	
	}
	else {
		image_angle = rotateAngle	
	}
}