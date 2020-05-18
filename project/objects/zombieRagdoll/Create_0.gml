torso = instance_create_layer(x,y,"Instances",zombiePart)
torso.sprite_index = s_zombie_torso
torso.mask_index = s_zombie_torso
torso.depth = 1

right_arm_upper = instance_create_layer(x-13,y-22,"Instances",zombiePart)
right_arm_upper.sprite_index = s_zombie_right_arm_upper
right_arm_upper.mask_index = s_zombie_right_arm_upper

physics_joint_revolute_create(torso, right_arm_upper, x-13, y-22, 0, 0, 0, 0, 0, 0, 0)

right_arm_upper.fixture = physics_fixture_create()
physics_fixture_set_polygon_shape(right_arm_upper.fixture)
physics_fixture_add_point(right_arm_upper.fixture, -3, -7)
physics_fixture_add_point(right_arm_upper.fixture, 17, -7)
physics_fixture_add_point(right_arm_upper.fixture, 17, 26)
physics_fixture_add_point(right_arm_upper.fixture, -3, 26)
physics_fixture_bind(right_arm_upper.fixture, right_arm_upper)


right_arm_lower = instance_create_layer(right_arm_upper.x+9,right_arm_upper.y+19,"Instances",zombiePart)
right_arm_lower.sprite_index = s_zombie_right_arm_lower
right_arm_lower.mask_index = s_zombie_right_arm_lower

physics_joint_revolute_create(right_arm_upper, right_arm_lower, right_arm_upper.x+9, right_arm_upper.y+19, -45, 45, true, 0, 0, 0, 0)
right_arm_lower.fixture = physics_fixture_create()
physics_fixture_set_polygon_shape(right_arm_lower.fixture)
physics_fixture_add_point(right_arm_lower.fixture, 0, -12)
physics_fixture_add_point(right_arm_lower.fixture, 22, -12)
physics_fixture_add_point(right_arm_lower.fixture, 22, 5)
physics_fixture_add_point(right_arm_lower.fixture, 0, 5)
physics_fixture_bind(right_arm_lower.fixture, right_arm_lower)

right_arm_hand = instance_create_layer(right_arm_lower.x+19,right_arm_lower.y-8,"Instances",zombiePart)
right_arm_hand.sprite_index = s_zombie_right_arm_hand
right_arm_hand.mask_index = s_zombie_right_arm_hand

physics_joint_revolute_create(right_arm_lower, right_arm_hand, right_arm_lower.x+19, right_arm_lower.y-8, 0, 0, 0, 0, 0, 0, 0)


left_arm_upper = instance_create_layer(x+11,y-24,"Instances",zombiePart)
left_arm_upper.sprite_index = s_zombie_left_arm_upper
left_arm_upper.mask_index = s_zombie_left_arm_upper

physics_joint_revolute_create(torso, left_arm_upper, x+11, y-24, 0, 0, 0, 0, 0, 0, 0)


left_arm_lower = instance_create_layer(left_arm_upper.x+9,left_arm_upper.y+19,"Instances",zombiePart)
left_arm_lower.sprite_index = s_zombie_left_arm_lower
left_arm_lower.mask_index = s_zombie_left_arm_lower

physics_joint_revolute_create(left_arm_upper, left_arm_lower, left_arm_upper.x+9, left_arm_upper.y+19, -45, 45, true, 0, 0, 0, 0)


left_arm_hand = instance_create_layer(left_arm_lower.x+17,left_arm_lower.y-11,"Instances",zombiePart)
left_arm_hand.sprite_index  = s_zombie_left_arm_hand
left_arm_hand.mask_index  = s_zombie_left_arm_hand

physics_joint_revolute_create(left_arm_lower, left_arm_hand, left_arm_lower.x+17, left_arm_lower.y-11, 0, 0, 0, 0, 0, 0, 0)


right_leg_upper = instance_create_layer(torso.x-7,torso.y+13,"Instances",zombiePart)
right_leg_upper.sprite_index = s_zombie_right_leg_upper
right_leg_upper.mask_index = s_zombie_right_leg_upper

physics_joint_revolute_create(torso, right_leg_upper, torso.x-7, torso.y+13, -10, 10, true, 0, 0, 0, 0)


right_leg_lower = instance_create_layer(right_leg_upper.x-6,right_leg_upper.y+24,"Instances",zombiePart)
right_leg_lower.sprite_index = s_zombie_right_leg_lower
right_leg_lower.mask_index = s_zombie_right_leg_lower

physics_joint_revolute_create(right_leg_upper, right_leg_lower, right_leg_upper.x-6, right_leg_upper.y+24, -90, 90, true, 0, 0, 0, 0)


left_leg_upper = instance_create_layer(torso.x+10,torso.y+13,"Instances",zombiePart)
left_leg_upper.sprite_index = s_zombie_left_leg_upper
left_leg_upper.mask_index = s_zombie_left_leg_upper

physics_joint_revolute_create(torso, left_leg_upper, torso.x+10, torso.y+13, -10, 10, true, 0, 0, 0, 0)


left_leg_lower = instance_create_layer(left_leg_upper.x+1,left_leg_upper.y+20,"Instances",zombiePart)
left_leg_lower.sprite_index = s_zombie_left_leg_lower
left_leg_lower.mask_index = s_zombie_left_leg_lower

physics_joint_revolute_create(left_leg_upper, left_leg_lower, left_leg_upper.x+1, left_leg_upper.y+20, -90, 90, true, 0, 0, 0, 0)
