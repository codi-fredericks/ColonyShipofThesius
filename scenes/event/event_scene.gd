extends VBoxContainer

@export_category("Controls")
@export var prompt_textbox: Label
@export var button_container: VBoxContainer

var game: Game
var ship: Ship
var current_event: Event


func _ready() -> void:
	await Engine.get_main_loop().process_frame
	game = NodeFinder.get_game_root()
	ship = game.ship

	current_event = game.get_current_event()
	fill_prompt()

func get_next_event() -> void:
	game.advance_trip()
	current_event = game.get_current_event()
	fill_prompt()

func fill_prompt() -> void:
	prompt_textbox.text = current_event.prompt

	current_event.do_event()

	for child in button_container.get_children():
		child.queue_free()

	for option in current_event.options:
		var new_button = Button.new()
		new_button.text = option.text
		if ship.meets_requirements(option.requirements):
			new_button.connect("pressed", _on_option_selected.bind(option))
		else:
			new_button.disabled = true

		button_container.add_child(new_button)

func _on_option_selected(option: EventOption) -> void:
	if ship.meets_requirements(option.requirements):
		option.do_option(ship)
		get_next_event()