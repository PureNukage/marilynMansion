//var bullet = instance_place(x,y,projectile)
var ragdoll = instance_create_layer(x,y,"Instances",zombieRagdoll)
with ragdoll {
	image_xscale = other.image_xscale
	//force = bullet.Speed
	//Direction = bullet.Direction
		
	torso = instance_create_layer(x,y,"Instances",zombieBody)
	torso.depth = 1
	torso.image_xscale = image_xscale
	torso.ID = id
		
	head = instance_create_layer(x,y-29,"Instances",zombieHead)
	head.image_xscale = image_xscale
	head.ID = id
		
	var xx = 1 * image_xscale
	var yy = -29 //* image_xscale
	with head {
		physics_joint_revolute_create(other.torso, id, other.x+xx, other.y+yy, -5, 5, true, 0, 0, 0, 0)

		//fixture = physics_fixture_create()
		//physics_fixture_set_polygon_shape(fixture)
		//physics_fixture_add_point(fixture, -3, -7)
		//physics_fixture_add_point(fixture, 17, -7)
		//physics_fixture_add_point(fixture, 17, 26)
		//physics_fixture_add_point(fixture, -3, 26)
		//physics_fixture_bind(fixture, id)
	}

	var xx = -10 * image_xscale
	var yy = -14 //* image_xscale
	right_arm_upper = instance_create_layer(x+xx,y+yy,"Instances",zombieRightArmUpper)
	with right_arm_upper {
		image_xscale = other.image_xscale
		ID = other.id

		physics_joint_revolute_create(other.torso, id, other.x+xx, other.y+yy, -90, 90, true, 0, 0, 0, 0)

		//fixture = physics_fixture_create()
		//physics_fixture_set_polygon_shape(fixture)
		//physics_fixture_add_point(fixture, -3, -7)
		//physics_fixture_add_point(fixture, 17, -7)
		//physics_fixture_add_point(fixture, 17, 26)
		//physics_fixture_add_point(fixture, -3, 26)
		//physics_fixture_bind(fixture, id)
	}

	
	var xx = 9 * image_xscale
	var yy = 19 //* image_xscale
	right_arm_lower = instance_create_layer(right_arm_upper.x+xx,right_arm_upper.y+yy,"Instances",zombieRightArmLower)
	right_arm_lower.image_xscale = image_xscale
	right_arm_lower.ID = id

	physics_joint_revolute_create(right_arm_upper, right_arm_lower, right_arm_upper.x+xx, right_arm_upper.y+yy, -45, 45, true, 0, 0, 0, 0)
	//right_arm_lower.fixture = physics_fixture_create()
	//physics_fixture_set_polygon_shape(right_arm_lower.fixture)
	//physics_fixture_add_point(right_arm_lower.fixture, 0, -12)
	//physics_fixture_add_point(right_arm_lower.fixture, 22, -12)
	//physics_fixture_add_point(right_arm_lower.fixture, 22, 5)
	//physics_fixture_add_point(right_arm_lower.fixture, 0, 5)
	//physics_fixture_bind(right_arm_lower.fixture, right_arm_lower)

	var xx = 19 * image_xscale
	var yy = -8 //* image_xscale
	right_arm_hand = instance_create_layer(right_arm_lower.x+xx,right_arm_lower.y+yy,"Instances",zombieRightArmHand)
	right_arm_hand.image_xscale = image_xscale
	right_arm_hand.ID = id

	physics_joint_revolute_create(right_arm_lower, right_arm_hand, right_arm_lower.x+xx, right_arm_lower.y+yy, -45, 45, true, 0, 0, 0, 0)
	//right_arm_hand.fixture = physics_fixture_create()
	//physics_fixture_set_polygon_shape(right_arm_hand.fixture)
	//physics_fixture_add_point(right_arm_hand.fixture, -1, -5)
	//physics_fixture_add_point(right_arm_hand.fixture, 13, -5)
	//physics_fixture_add_point(right_arm_hand.fixture, 13, 11)
	//physics_fixture_add_point(right_arm_hand.fixture, -1, 11)
	//physics_fixture_bind(right_arm_hand.fixture, right_arm_hand)

	var xx = 11 * image_xscale
	var yy = -24 //* image_xscale
	left_arm_upper = instance_create_layer(x+xx,y+yy,"Instances",zombieLeftArmUpper)
	left_arm_upper.image_xscale = image_xscale
	left_arm_upper.ID = id

	physics_joint_revolute_create(torso, left_arm_upper, x+xx, y+yy, -90, 90, true, 0, 0, 0, 0)
	//left_arm_upper.fixture = physics_fixture_create()
	//physics_fixture_set_polygon_shape(left_arm_upper.fixture)
	//physics_fixture_add_point(left_arm_upper.fixture, -2, -5)
	//physics_fixture_add_point(left_arm_upper.fixture, 13, -5)
	//physics_fixture_add_point(left_arm_upper.fixture, 13, 23)
	//physics_fixture_add_point(left_arm_upper.fixture, -2, 23)
	//physics_fixture_bind(left_arm_upper.fixture, left_arm_upper)


	var xx = 9 * image_xscale
	var yy = 19 //* image_xscale
	left_arm_lower = instance_create_layer(left_arm_upper.x+xx,left_arm_upper.y+yy,"Instances",zombieLeftArmLower)
	left_arm_lower.image_xscale = image_xscale
	left_arm_lower.ID = id

	physics_joint_revolute_create(left_arm_upper, left_arm_lower, left_arm_upper.x+xx, left_arm_upper.y+yy, -45, 45, true, 0, 0, 0, 0)
	//left_arm_lower.fixture = physics_fixture_create()
	//physics_fixture_set_polygon_shape(left_arm_lower.fixture)
	//physics_fixture_add_point(left_arm_lower.fixture, -2, -16)
	//physics_fixture_add_point(left_arm_lower.fixture, 20, -16)
	//physics_fixture_add_point(left_arm_lower.fixture, 20, 7)
	//physics_fixture_add_point(left_arm_lower.fixture, -2, 7)
	//physics_fixture_bind(left_arm_lower.fixture, left_arm_lower)


	var xx = 17 * image_xscale
	var yy = -11 //* image_xscale
	left_arm_hand = instance_create_layer(left_arm_lower.x+xx,left_arm_lower.y+yy,"Instances",zombieLeftArmHand)
	left_arm_hand.image_xscale = image_xscale
	left_arm_hand.ID = id

	physics_joint_revolute_create(left_arm_lower, left_arm_hand, left_arm_lower.x+xx, left_arm_lower.y+yy, -45, 45, true, 0, 0, 0, 0)
	//left_arm_hand.fixture = physics_fixture_create()
	//physics_fixture_set_polygon_shape(left_arm_hand.fixture)
	//physics_fixture_add_point(left_arm_hand.fixture, -3, -4)
	//physics_fixture_add_point(left_arm_hand.fixture, 13, -4)
	//physics_fixture_add_point(left_arm_hand.fixture, 13, 18)
	//physics_fixture_add_point(left_arm_hand.fixture, -3, 18)
	//physics_fixture_bind(left_arm_hand.fixture, left_arm_hand)


	var xx = -7 * image_xscale
	var yy = 13 //* image_xscale
	right_leg_upper = instance_create_layer(torso.x+xx,torso.y+yy,"Instances",zombieRightLegUpper)
	right_leg_upper.image_xscale = image_xscale
	right_leg_upper.ID = id

	physics_joint_revolute_create(torso, right_leg_upper, torso.x+xx, torso.y+yy, -10, 10, true, 0, 0, 0, 0)

	var xx = -6 * image_xscale
	var yy = 24 //* image_xscale
	right_leg_lower = instance_create_layer(right_leg_upper.x+xx,right_leg_upper.y+yy,"Instances",zombieRightLegLower)
	right_leg_lower.image_xscale = image_xscale
	right_leg_lower.ID = id

	physics_joint_revolute_create(right_leg_upper, right_leg_lower, right_leg_upper.x+xx, right_leg_upper.y+yy, -90, 90, true, 0, 0, 0, 0)

	var xx = 10 * image_xscale
	var yy = 13 //* image_xscale
	left_leg_upper = instance_create_layer(torso.x+xx,torso.y+yy,"Instances",zombieLeftLegUpper)
	left_leg_upper.image_xscale = image_xscale
	left_leg_upper.ID = id

	physics_joint_revolute_create(torso, left_leg_upper, torso.x+xx, torso.y+yy, -10, 10, true, 0, 0, 0, 0)

	var xx = 1 * image_xscale
	var yy = 20 //* image_xscale
	left_leg_lower = instance_create_layer(left_leg_upper.x+xx,left_leg_upper.y+yy,"Instances",zombieLeftLegLower)
	left_leg_lower.image_xscale = image_xscale
	left_leg_lower.ID = id

	physics_joint_revolute_create(left_leg_upper, left_leg_lower, left_leg_upper.x+xx, left_leg_upper.y+yy, -90, 90, true, 0, 0, 0, 0)
	
	
}
dead = 1
