fixture = physics_fixture_create()
physics_fixture_set_box_shape(fixture, (bbox_right-bbox_left)/2, (bbox_bottom-bbox_top)/2)
physics_fixture_bind_ext(fixture, id, -(bbox_right-bbox_left)/2,-(bbox_bottom-bbox_top)/2)
Floor = 0