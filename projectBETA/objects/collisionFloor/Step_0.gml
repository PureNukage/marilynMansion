if place_meeting(x,y,player) {
	
	var oldDepth = depth
	
	//	The player is above the floor
	if player.bbox_bottom <= bbox_bottom {
		//	The player is on the stairs and the stairs go to the floor under
		if player.onStairs and player.onStairs.bottomFloor < Floor {
			//	The player is climbing through the stair hole
			if player.bbox_bottom >= bbox_top+16 {
				depth = -500
			} 
			//	The player is standing on the floor
			else {
				depth = 500
				if instance_exists(stairs) with stairs if topFloor <= other.Floor depth = 501
			}
		}
		//	The player is not on the stairs and is standing on the floor
		else {
			depth = 500
			if instance_exists(stairs) with stairs if topFloor <= other.Floor depth = 501
		}
	}
	//	The player is under the floor
	else {
		depth = -50	
		if instance_exists(stairs) with stairs if bottomFloor <= other.Floor depth = 400
	}
	
	if oldDepth != depth if instance_exists(class_light) with class_light {
		//create_light()
		debug.log("refreshing lights")
	}
	
}