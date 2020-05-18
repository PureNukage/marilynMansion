//#region Spawning Parts 
//	if !spawnedParts {
//		spawnedParts = true
	
//		torso = instance_create_layer(x,y,"Instances",zombiePart)
//		torso.sprite_index = s_zombie_body
//		torso.mask_index = s_zombie_body
//		torso.depth = 1
//		torso.image_xscale = image_xscale
//		torso.ID = id
		
//		head = instance_create_layer(x,y-29,"Instances",zombiePart)
//		head.sprite_index = s_zombie_head
//		head.mask_index = s_zombie_head
//		head.image_xscale = image_xscale
//		head.ID = id
		
//		var xx = 1 * image_xscale
//		var yy = -29 //* image_xscale
//		with head {
//			physics_joint_revolute_create(other.torso, id, x+xx, y+yy, -5, 5, true, 0, 0, 0, 0)

//			//fixture = physics_fixture_create()
//			//physics_fixture_set_polygon_shape(fixture)
//			//physics_fixture_add_point(fixture, -3, -7)
//			//physics_fixture_add_point(fixture, 17, -7)
//			//physics_fixture_add_point(fixture, 17, 26)
//			//physics_fixture_add_point(fixture, -3, 26)
//			//physics_fixture_bind(fixture, id)
//		}

//		var xx = -13 * image_xscale
//		var yy = -22 //* image_xscale
//		right_arm_upper = instance_create_layer(x+xx,y+yy,"Instances",zombiePart)
//		with right_arm_upper {
//			sprite_index = s_zombie_right_arm_upper
//			mask_index = s_zombie_right_arm_upper
//			image_xscale = other.image_xscale
//			ID = other.id

//			physics_joint_revolute_create(other.torso, id, x+xx, y+yy, -45, 45, true, 0, 0, 0, 0)

//			fixture = physics_fixture_create()
//			physics_fixture_set_polygon_shape(fixture)
//			physics_fixture_add_point(fixture, -3, -7)
//			physics_fixture_add_point(fixture, 17, -7)
//			physics_fixture_add_point(fixture, 17, 26)
//			physics_fixture_add_point(fixture, -3, 26)
//			physics_fixture_bind(fixture, id)
//		}

	
//		var xx = 9 * image_xscale
//		var yy = 19 //* image_xscale
//		right_arm_lower = instance_create_layer(right_arm_upper.x+xx,right_arm_upper.y+yy,"Instances",zombiePart)
//		right_arm_lower.sprite_index = s_zombie_right_arm_lower
//		right_arm_lower.mask_index = s_zombie_right_arm_lower
//		right_arm_lower.image_xscale = image_xscale
//		right_arm_lower.ID = id

//		physics_joint_revolute_create(right_arm_upper, right_arm_lower, right_arm_upper.x+xx, right_arm_upper.y+yy, -45, 45, true, 0, 0, 0, 0)
//		right_arm_lower.fixture = physics_fixture_create()
//		physics_fixture_set_polygon_shape(right_arm_lower.fixture)
//		physics_fixture_add_point(right_arm_lower.fixture, 0, -12)
//		physics_fixture_add_point(right_arm_lower.fixture, 22, -12)
//		physics_fixture_add_point(right_arm_lower.fixture, 22, 5)
//		physics_fixture_add_point(right_arm_lower.fixture, 0, 5)
//		physics_fixture_bind(right_arm_lower.fixture, right_arm_lower)

//		var xx = 19 * image_xscale
//		var yy = -8 //* image_xscale
//		right_arm_hand = instance_create_layer(right_arm_lower.x+xx,right_arm_lower.y+yy,"Instances",zombiePart)
//		right_arm_hand.sprite_index = s_zombie_right_arm_hand
//		right_arm_hand.mask_index = s_zombie_right_arm_hand
//		right_arm_hand.image_xscale = image_xscale
//		right_arm_hand.ID = id

//		physics_joint_revolute_create(right_arm_lower, right_arm_hand, right_arm_lower.x+xx, right_arm_lower.y+yy, -45, 45, true, 0, 0, 0, 0)
//		right_arm_hand.fixture = physics_fixture_create()
//		physics_fixture_set_polygon_shape(right_arm_hand.fixture)
//		physics_fixture_add_point(right_arm_hand.fixture, -1, -5)
//		physics_fixture_add_point(right_arm_hand.fixture, 13, -5)
//		physics_fixture_add_point(right_arm_hand.fixture, 13, 11)
//		physics_fixture_add_point(right_arm_hand.fixture, -1, 11)
//		physics_fixture_bind(right_arm_hand.fixture, right_arm_hand)

//		var xx = 11 * image_xscale
//		var yy = -24 //* image_xscale
//		left_arm_upper = instance_create_layer(x+xx,y+yy,"Instances",zombiePart)
//		left_arm_upper.sprite_index = s_zombie_left_arm_upper
//		left_arm_upper.mask_index = s_zombie_left_arm_upper
//		left_arm_upper.image_xscale = image_xscale
//		left_arm_upper.ID = id

//		physics_joint_revolute_create(torso, left_arm_upper, x+xx, y+yy, -45, 45, true, 0, 0, 0, 0)
//		left_arm_upper.fixture = physics_fixture_create()
//		physics_fixture_set_polygon_shape(left_arm_upper.fixture)
//		physics_fixture_add_point(left_arm_upper.fixture, -2, -5)
//		physics_fixture_add_point(left_arm_upper.fixture, 13, -5)
//		physics_fixture_add_point(left_arm_upper.fixture, 13, 23)
//		physics_fixture_add_point(left_arm_upper.fixture, -2, 23)
//		physics_fixture_bind(left_arm_upper.fixture, left_arm_upper)


//		var xx = 9 * image_xscale
//		var yy = 19 //* image_xscale
//		left_arm_lower = instance_create_layer(left_arm_upper.x+xx,left_arm_upper.y+yy,"Instances",zombiePart)
//		left_arm_lower.sprite_index = s_zombie_left_arm_lower
//		left_arm_lower.mask_index = s_zombie_left_arm_lower
//		left_arm_lower.image_xscale = image_xscale
//		left_arm_lower.ID = id

//		physics_joint_revolute_create(left_arm_upper, left_arm_lower, left_arm_upper.x+xx, left_arm_upper.y+yy, -45, 45, true, 0, 0, 0, 0)
//		left_arm_lower.fixture = physics_fixture_create()
//		physics_fixture_set_polygon_shape(left_arm_lower.fixture)
//		physics_fixture_add_point(left_arm_lower.fixture, -2, -16)
//		physics_fixture_add_point(left_arm_lower.fixture, 20, -16)
//		physics_fixture_add_point(left_arm_lower.fixture, 20, 7)
//		physics_fixture_add_point(left_arm_lower.fixture, -2, 7)
//		physics_fixture_bind(left_arm_lower.fixture, left_arm_lower)


//		var xx = 17 * image_xscale
//		var yy = -11 //* image_xscale
//		left_arm_hand = instance_create_layer(left_arm_lower.x+xx,left_arm_lower.y+yy,"Instances",zombiePart)
//		left_arm_hand.sprite_index  = s_zombie_left_arm_hand
//		left_arm_hand.mask_index  = s_zombie_left_arm_hand
//		left_arm_hand.image_xscale = image_xscale
//		left_arm_hand.ID = id

//		physics_joint_revolute_create(left_arm_lower, left_arm_hand, left_arm_lower.x+xx, left_arm_lower.y+yy, -45, 45, true, 0, 0, 0, 0)
//		left_arm_hand.fixture = physics_fixture_create()
//		physics_fixture_set_polygon_shape(left_arm_hand.fixture)
//		physics_fixture_add_point(left_arm_hand.fixture, -3, -4)
//		physics_fixture_add_point(left_arm_hand.fixture, 13, -4)
//		physics_fixture_add_point(left_arm_hand.fixture, 13, 18)
//		physics_fixture_add_point(left_arm_hand.fixture, -3, 18)
//		physics_fixture_bind(left_arm_hand.fixture, left_arm_hand)


//		var xx = -7 * image_xscale
//		var yy = 13 //* image_xscale
//		right_leg_upper = instance_create_layer(torso.x+xx,torso.y+yy,"Instances",zombiePart)
//		right_leg_upper.sprite_index = s_zombie_right_leg_upper
//		right_leg_upper.mask_index = s_zombie_right_leg_upper
//		right_leg_upper.image_xscale = image_xscale
//		right_leg_upper.ID = id

//		physics_joint_revolute_create(torso, right_leg_upper, torso.x+xx, torso.y+yy, -10, 10, true, 0, 0, 0, 0)

//		var xx = -6 * image_xscale
//		var yy = 24 //* image_xscale
//		right_leg_lower = instance_create_layer(right_leg_upper.x+xx,right_leg_upper.y+yy,"Instances",zombiePart)
//		right_leg_lower.sprite_index = s_zombie_right_leg_lower
//		right_leg_lower.mask_index = s_zombie_right_leg_lower
//		right_leg_lower.image_xscale = image_xscale
//		right_leg_lower.ID = id

//		physics_joint_revolute_create(right_leg_upper, right_leg_lower, right_leg_upper.x+xx, right_leg_upper.y+yy, -90, 90, true, 0, 0, 0, 0)

//		var xx = 10 * image_xscale
//		var yy = 13 //* image_xscale
//		left_leg_upper = instance_create_layer(torso.x+xx,torso.y+yy,"Instances",zombiePart)
//		left_leg_upper.sprite_index = s_zombie_left_leg_upper
//		left_leg_upper.mask_index = s_zombie_left_leg_upper
//		left_leg_upper.image_xscale = image_xscale
//		left_leg_upper.ID = id

//		physics_joint_revolute_create(torso, left_leg_upper, torso.x+xx, torso.y+yy, -10, 10, true, 0, 0, 0, 0)

//		var xx = 1 * image_xscale
//		var yy = 20 //* image_xscale
//		left_leg_lower = instance_create_layer(left_leg_upper.x+xx,left_leg_upper.y+yy,"Instances",zombiePart)
//		left_leg_lower.sprite_index = s_zombie_left_leg_lower
//		left_leg_lower.mask_index = s_zombie_left_leg_lower
//		left_leg_lower.image_xscale = image_xscale
//		left_leg_lower.ID = id

//		physics_joint_revolute_create(left_leg_upper, left_leg_lower, left_leg_upper.x+xx, left_leg_upper.y+yy, -90, 90, true, 0, 0, 0, 0)

//	}
//#endregion

//if spawnedParts {
		
	if force > 0 {
		
		var xx = lengthdir_x(force*100, Direction)
		//var yy = lengthdir_y(force*600, Direction)
		
		with zombiePart if ID == other.id physics_apply_force(x,y, xx, 0)
		
		force = 0
		
		
		
	}	
	
//}