extends HBoxContainer

@export var engines: RichTextLabel
@export var sensors: RichTextLabel
@export var refinery: RichTextLabel
@export var science: RichTextLabel
@export var shields: RichTextLabel
@export var weapons: RichTextLabel

var game: Game
var ship: Ship

func _ready() -> void:
	await Engine.get_main_loop().process_frame
	game = NodeFinder.get_game_root()
	ship = game.ship

	ship.system_damaged.connect(_update_system)
	ship.system_recovered.connect(_update_system)

	for system in Constants.SYSTEM_NAMES:
		_update_system(system)

func _update_system(system: String) -> void:
	var system_node: RichTextLabel = get(system)
	var system_value: int = ship.get_system(system)

	system_node.text = ""

	if not ship.is_original(system):
		system_node.push_color(ColorManager.get_refurbished_color())
	if system_value <= 0:
		system_node.push_color(ColorManager.get_system_color(0))

	system_node.append_text(Constants.ABBREVIATIONS[system])
	system_node.pop_all()

	system_node.append_text(" ")

	system_node.push_color(ColorManager.get_system_color(system_value))
	system_node.append_text("[")

	var system_string: String = "/"
	if system_value > 0:
		system_string = "|".repeat(system_value)
	system_node.append_text(system_string)

	system_node.append_text("]")
	system_node.pop()
