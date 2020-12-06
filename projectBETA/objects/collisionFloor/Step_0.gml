if place_meeting(x,y,player) {
	
	if player.bbox_bottom <= bbox_bottom {
		if player.onStairs and player.onStairs.bottomFloor < Floor { 
			depth = -50	
		}
		else {
			depth = 500
			if instance_exists(stairs) with stairs if topFloor <= other.Floor depth = 501
		}
	}
	
	else {
		depth = -50	
		if instance_exists(stairs) with stairs if bottomFloor <= other.Floor depth = 400
	}
	
}