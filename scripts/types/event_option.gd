class_name EventOption
extends Resource

@export var text: String

@export_category("FX")
@export var sfx: StringName = &""
@export var screen_shake: bool = false

@export_category("Choice Info")
@export var requirements: ShipData
@export var effect: ShipData
@export var trip_length_mod: int

func do_option(ship: Ship) -> void:
	print(text)

	if sfx != &"":
		SfxService.play(sfx)

	if screen_shake:
		ShakeService.shake()

	ship.add_effect(effect)

	if trip_length_mod > 0:
		NodeFinder.get_game_root().add_event_stop(trip_length_mod)
	elif trip_length_mod < 0:
		NodeFinder.get_game_root().remove_event_stop(trip_length_mod)