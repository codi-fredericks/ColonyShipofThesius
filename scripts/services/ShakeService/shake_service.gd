extends Node

var shaker: ScreenShaker

func shake() -> void:
	if not is_instance_valid(shaker):
		shaker = NodeFinder.get_screen_shaker()

	shaker.shake()