extends CenterContainer

@export var engines: TextureRect
@export var sensors: TextureRect
@export var refinery: TextureRect
@export var science: TextureRect
@export var shields: TextureRect
@export var weapons: TextureRect

var game: Game
var ship: Ship

func _ready() -> void:
	await Engine.get_main_loop().process_frame
	game = NodeFinder.get_game_root()
	ship = game.ship

	ship.system_damaged.connect(_update_system_color)
	ship.system_recovered.connect(_update_system_color)

	for system in Constants.SYSTEM_NAMES:
		_update_system_color(system)


func _update_system_color(system: String) -> void:
	var system_node: TextureRect = get(system)
	var system_value: int = ship.get_system(system)

	system_node.modulate = ColorManager.get_system_color(system_value)
