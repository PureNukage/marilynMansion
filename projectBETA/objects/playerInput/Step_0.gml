keyRight = keyboard_check(ord("D"))
keyLeft = keyboard_check(ord("A"))
keyUp = keyboard_check(ord("W"))
keyDown = keyboard_check(ord("S"))

mouseLeft = mouse_check_button(mb_left)
mouseLeftPress = mouse_check_button_pressed(mb_left)

mouseRight = mouse_check_button(mb_right)
mouseRightPress = mouse_check_button_pressed(mb_right)
mouseRightRelease = mouse_check_button_released(mb_right)

mouseMiddle = mouse_check_button(mb_middle)
mouseMiddlePress = mouse_check_button_pressed(mb_middle)
mouseMiddleRelease = mouse_check_button_released(mb_middle)

keyInteract = keyboard_check(ord("E"))

keyFlashlight = keyboard_check_pressed(ord("F"))

keyReload = keyboard_check_pressed(ord("R"))

keyLoot = keyboard_check_pressed(vk_tab)

keyLeftHand = keyboard_check_pressed(ord("1"))
keyRightHand = keyboard_check_pressed(ord("2"))
keyBothHand = keyboard_check_pressed(ord("3"))

if keyboard_check_pressed(vk_space) {
	game_restart()	
}