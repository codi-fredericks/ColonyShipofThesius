extends HBoxContainer

@export var engines: RichTextLabel
@export var sensors: RichTextLabel
@export var refinery: RichTextLabel
@export var science: RichTextLabel
@export var shields: RichTextLabel
@export var weapons: RichTextLabel

var game: Game
var ship: Ship

var abbreviations: Dictionary[String, String] = {
	"engines": "ENGN",
	"sensors": "SENS",
	"refinery": "REFN",
	"science": "SCIN",
	"shields": "SHLD",
	"weapons": "WEPN",
}

func _ready() -> void:
	await Engine.get_main_loop().process_frame
	game = NodeFinder.get_game_root()
	ship = game.ship

	ship.system_damaged.connect(_update_system)
	ship.system_recovered.connect(_update_system)

	for system in Constants.SYSTEM_NAMES:
		_update_system(system, 0)

func _update_system(system: String, _delta: int) -> void:
	var system_node: RichTextLabel = get(system)
	var system_value: int = ship.get_system(system)

	system_node.text = ""
	system_node.append_text(abbreviations[system])
	system_node.append_text(" ")

	system_node.push_color(ColorManager.get_system_color(system_value))
	system_node.append_text("[")

	var system_string: String = "/"
	if system_value > 0:
		system_string = "|".repeat(system_value)
	system_node.append_text(system_string)

	system_node.append_text("]")
	system_node.pop()