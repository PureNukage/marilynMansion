depth = -2

ID = -1

function applyDecal(ID) {
	var Width = sprite_get_width(ID.ragdoll.sprite_index)
	var Height = sprite_get_height(ID.ragdoll.sprite_index)
	var surface = create_surface(Width, Height)
	
	surface_set_target(surface)
	
	var originX = sprite_get_xoffset(ID.sprite_index)
	var originY = sprite_get_yoffset(ID.sprite_index)
	
	var ragdollOriginX = ID.ragdoll.x - sprite_get_xoffset(ID.ragdoll.sprite_index)
	var ragdollOriginY = ID.ragdoll.y - sprite_get_yoffset(ID.ragdoll.sprite_index)
	
	var bodypartX = ID.x - ragdollOriginX
	var bodypartY = ID.y - ragdollOriginY
	
	var bloodX = x - ragdollOriginX
	var bloodY = y - ragdollOriginY
	
	draw_sprite_ext(sprite_index,0,bloodX,bloodY,1,1,0,c_white,1)
	
	surface_reset_target()
	
	var bloodSprite = sprite_create_from_surface(surface,0,0,Width,Height,false,false,bodypartX,bodypartY)
	
	var bloodMapSurface = create_surface(Width,Height)
	surface_set_target(bloodMapSurface)
	
	//draw_sprite_ext(ID.sprite_index,0,originX,originY,1,1,0,c_black,1)
	draw_sprite_ext(ID.sprite_index,0,bodypartX,bodypartY,1,1,0,c_black,1)
	gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
	var Angle = ID.image_angle
	if ID.image_xscale == 1 Angle *= -1
	debug.log("ID.image_angle: "+string(ID.image_angle))
	draw_sprite_ext(bloodSprite,0,bodypartX,bodypartY,ID.image_xscale,1,Angle,c_white,1)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	var finalSurface = create_surface(Width, Height)
	surface_set_target(finalSurface)
	
	draw_sprite_ext(ID.sprite_index,0,originX,originY,1,1,0,c_white,1)
	
	draw_surface(bloodMapSurface,originX-bodypartX,originY-bodypartY)
	
	surface_reset_target()
	
	var finalSprite = sprite_create_from_surface(finalSurface,0,0,Width,Height,false,false,originX,originY)
	
	ID.sprite_index = finalSprite
	
	sprite_save(bloodSprite,0,"decalBloodSprite.png")
	surface_save(bloodMapSurface,"decalBloodMapSurface.png")
	sprite_save(finalSprite,0,"decalFinalSprite.png")
	
	surface_free(surface)
	surface_free(bloodMapSurface)
	surface_free(finalSurface)
	sprite_delete(bloodSprite)
	
	instance_destroy()
	
}