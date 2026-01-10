extends Node

var _game: Game
var _screen_shaker: ScreenShaker

func get_game_root() -> Game:
	if is_instance_valid(_game):
		return(_game)

	_game = get_tree().get_first_node_in_group("game")

	return(_game)

func get_screen_shaker() -> ScreenShaker:
	if is_instance_valid(_screen_shaker):
		return(_screen_shaker)

	_screen_shaker = get_tree().get_first_node_in_group("camera")

	return(_screen_shaker)