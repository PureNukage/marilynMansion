flashlightOn = game.Player.flashlightOn
inventoryIndex = game.Player.inventoryIndex
change_inventory(inventoryIndex)

var old_xscale = image_xscale
image_xscale = game.Player.image_xscale
if old_xscale != image_xscale {
	var X = (x + (arm1_offsetX*old_xscale)) + lengthdir_x(50, gunRotation)
	var Y = y+arm1_offsetY + lengthdir_y(50, gunRotation)
	var newWidth = abs(X - (x + (arm1_offsetX*old_xscale)))
	var newX = (x + (arm1_offsetX*image_xscale)) + (image_xscale * newWidth)
	gunRotation = point_direction((x + (arm1_offsetX*image_xscale)),y+arm1_offsetY, newX,Y)
}
