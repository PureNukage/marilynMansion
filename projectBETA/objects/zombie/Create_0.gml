event_inherited()

sprite = s_zombie_walk
sprite_index = sprite

states = states.free

#region Zombie Bodyparts

	var b = 0 // Part Index

	//	Torso
	bodyparts[b][bodyparts_enum] = bodyParts.torso
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_torso,
		fix_width: 30,
		fix_height: 45,
		fix_offsetX: 0,
		fix_offsetY: 0,
		fix_density: 5,
		fix_friction: 3,
		min_angle: -1,
		max_angle: -1,
		angle: false,
		bind: -1
	}
	b++
	
	//	Head
	bodyparts[b][bodyparts_enum] = bodyParts.head
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_head,
		fix_width: 30,
		fix_height: 30,
		fix_offsetX: 2,
		fix_offsetY: -16,
		fix_density: 8,
		fix_friction: 3,
		angle: true,
		min_angle: -20,
		max_angle: 20,
		bind: 0
	}
	b++
	
	//	Right Arm Upper
	bodyparts[b][bodyparts_enum] = bodyParts.rightArmUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_right_arm_upper,
		fix_width: 19,
		fix_height: 28,
		fix_offsetX: 5,
		fix_offsetY: 9,
		fix_density: 3,
		fix_friction: 3,
		angle: true,
		min_angle: -75,
		max_angle: 75,
		bind: 0
	}
	b++

	//	Right Arm Lower
	bodyparts[b][bodyparts_enum] = bodyParts.rightArmLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_right_arm_lower,
		fix_width: 23,
		fix_height: 13,
		fix_offsetX: 10,
		fix_offsetY: -4,
		fix_density: 2,
		fix_friction: 3,
		angle: true,
		min_angle: -45,
		max_angle: 45,
		bind: 2
	}
	b++
	
	//	Right Arm Hand
	bodyparts[b][bodyparts_enum] = bodyParts.rightArmHand
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite: s_zombie_part_right_arm_hand,
		fix_width: 11,
		fix_height: 12,
		fix_offsetX: 3,
		fix_offsetY: 4,
		fix_density: 2,
		fix_friction: 3,
		angle: true,
		min_angle: -45,
		max_angle: 45,
		bind: 3
	}
	b++
	
	//	Left Arm Upper
	bodyparts[b][bodyparts_enum] = bodyParts.leftArmUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_arm_upper,
		fix_width:  13,
		fix_height:  26,
		fix_offsetX:  4,
		fix_offsetY:  6,
		fix_density: 3,
		fix_friction: 3,
		angle:  true,
		min_angle:  -75,
		max_angle:  75,
		bind:  0
	}
	b++
	
	//	Left Arm Lower
	bodyparts[b][bodyparts_enum] = bodyParts.leftArmLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_arm_lower,
		fix_width:  23,
		fix_height:  16,
		fix_offsetX:  7,
		fix_offsetY:  -5,
		fix_density: 2,
		fix_friction: 3,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  5
	}
	b++
	
	//	Left Arm Hand
	bodyparts[b][bodyparts_enum] = bodyParts.leftArmHand
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_arm_hand,
		fix_width:  14,
		fix_height:  15,
		fix_offsetX:  5,
		fix_offsetY:  5,
		fix_density: 2,
		fix_friction: 3,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  6
	}
	b++
	
	//	Right Leg Upper
	bodyparts[b][bodyparts_enum] = bodyParts.rightLegUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_right_leg_upper,
		fix_width:  14,
		fix_height:  25,
		fix_offsetX:  0,
		fix_offsetY:  11,
		fix_density: 3,
		fix_friction: 3,
		angle:  true,
		min_angle:  -10,
		max_angle:  10,
		bind:  0
	}
	b++
	
	//	Right Leg Lower
	bodyparts[b][bodyparts_enum] = bodyParts.rightLegLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_right_leg_lower,
		fix_width:  13,
		fix_height:  25,
		fix_offsetX:  2,
		fix_offsetY:  12,
		fix_density: 3,
		fix_friction: 1,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  8
	}
	b++
	
	//	Left Leg Upper
	bodyparts[b][bodyparts_enum] = bodyParts.leftLegUpper
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_leg_upper,
		fix_width:  18,
		fix_height:  25,
		fix_offsetX:  0,
		fix_offsetY:  10,
		fix_density: 3,
		fix_friction: 3,
		angle:  true,
		min_angle:  -10,
		max_angle:  10,
		bind:  0
	}
	b++
	
	//	Left Leg Lower
	bodyparts[b][bodyparts_enum] = bodyParts.leftLegLower
	bodyparts[b][bodyparts_id] = -1
	bodyparts[b][bodyparts_struct] = {
		sprite:  s_zombie_part_left_leg_lower,
		fix_width:  18,
		fix_height:  29,
		fix_offsetX:  0,
		fix_offsetY:  14,
		fix_density: 3,
		fix_friction: 1,
		angle:  true,
		min_angle:  -45,
		max_angle:  45,
		bind:  10
	}

#endregion

function die() {
	var ragDoll = instance_create_layer(x,y,"Instances",zombieRagdoll)
	ragDoll.bodyparts = bodyparts
	ragDoll.image_xscale = image_xscale
	ragDoll.spawnRagdoll()
	instance_destroy()	
}