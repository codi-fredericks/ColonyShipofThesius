extends VBoxContainer

@export_category("Controls")
@export var prompt_textbox: RichTextLabel
@export var button_container: VBoxContainer
@export var overflow_button_container: VBoxContainer
@export var event_image: TextureRect

var game: Game
var ship: Ship
var current_event: Event

var rich_button_scene: PackedScene = preload("res://scenes/event/RichButton/rich_button.tscn")

func _ready() -> void:
	await Engine.get_main_loop().process_frame
	game = NodeFinder.get_game_root()
	ship = game.ship

	current_event = game.get_current_event()
	if current_event.effects:
		ship.add_effects(current_event.effects)
	current_event.do_event()
	fill_prompt()


func get_next_event() -> void:
	game.advance_trip()
	current_event = game.get_current_event()
	if current_event.effects:
		ship.add_effects(current_event.effects)
	current_event.do_event()
	fill_prompt()

func fill_prompt() -> void:
	prompt_textbox.text = ""
	prompt_textbox.append_text(current_event.prompt)

	if current_event.effects:
		prompt_textbox.append_text(" [")
		append_effects(prompt_textbox, current_event.effects)
		prompt_textbox.append_text("]")

	if current_event.image:
		event_image.texture = event_image.texture
		event_image.show()
	else:
		event_image.texture = PlaceholderTexture2D.new()
		event_image.hide()

	_clear_button_containers()

	if current_event.options.size() > 3:
		overflow_button_container.show()
	else:
		overflow_button_container.hide()

	var option_index: int = 0
	for option in current_event.options:
		var new_button: RichButton = rich_button_scene.instantiate()

		if option_index >= 3:
			overflow_button_container.add_child(new_button)
		else:
			button_container.add_child(new_button)

		new_button.rich_text.text = ""
		new_button.rich_text.append_text(option.text)
		new_button.rich_text.append_text(" ")

		if not ship.meets_requirements(option.requirements):
			new_button.set_disabled(true)
			new_button.rich_text.push_color(ColorManager.get_system_color(0))
			new_button.rich_text.append_text("REQ:")
			new_button.rich_text.append_text(get_missing_requirement_string(option))
			new_button.rich_text.pop()
		else:
			new_button.rich_text.append_text("[")
			append_effects(new_button.rich_text, option.effects)
			new_button.rich_text.append_text("]")

		new_button.connect("pressed", _on_option_selected.bind(option))

		option_index += 1


func get_missing_requirement_string(option: EventOption) -> String:
	var out_string: String = ""

	for system in Constants.SYSTEM_NAMES:
		var current_requirement = option.requirements.get_system(system)
		if current_requirement == 0:
			continue

		if ship.get_system(system) < current_requirement:
			out_string += " "
			out_string += Constants.ABBREVIATIONS[system]
			out_string += " "
			out_string += str(current_requirement)

	return(out_string)

func append_effects(rich_text: RichTextLabel, effects: ShipData) -> void:
	var first: bool = true
	var num_found: int = 0

	for system in Constants.SYSTEM_NAMES:
		var this_effect = effects.get_system(system)
		if this_effect == 0:
			continue

		if not first:
			rich_text.append_text(", ")

		first = false

		if this_effect > 0:
			rich_text.push_color(ColorManager.get_system_color(2))
			rich_text.append_text(Constants.ABBREVIATIONS[system])
			rich_text.append_text(" +")
		else:
			rich_text.push_color(ColorManager.get_system_color(0))
			rich_text.append_text(Constants.ABBREVIATIONS[system])
			rich_text.append_text(" ")

		rich_text.append_text(str(this_effect))
		rich_text.pop()

		num_found += 1

	if num_found == 0:
		rich_text.push_color(ColorManager.get_disabled_color())
		rich_text.append_text("NO EFFECT")
		rich_text.pop()


func _on_option_selected(option: EventOption) -> void:
	if ship.meets_requirements(option.requirements):
		option.do_option(ship)
		get_next_event()

func _clear_button_containers() -> void:
	for child in button_container.get_children():
		child.queue_free()

	for child in overflow_button_container.get_children():
		child.queue_free()
