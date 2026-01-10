class_name Event
extends Resource

@export_category("Event Text")
@export var title: String = ""
@export_multiline var prompt : String = ""

@export_category("FX")
@export var sfx: StringName = &""
@export var warn_color: Color = Color8(0, 0, 0, 0)
@export var screen_shake: bool = false

@export_category("Options")
@export var options: Array[EventOption] = []

func do_event() -> void:
	if sfx != &"":
		SfxService.play(sfx)

	if screen_shake:
		ShakeService.shake()

	if warn_color != Color8(0, 0, 0, 0):
		pass