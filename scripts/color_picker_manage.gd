extends ColorPickerButton

@export var presets:bool = true
@export var sliders:bool = true
@export var sampler:bool = true
@export var color_modes:bool = true
@export var preset:LayoutPreset
var picker:ColorPicker = get_picker()

func _ready() -> void:
	picker.set_presets_visible(presets)
	picker.set_sliders_visible(sliders)
	picker.set_sampler_visible(sampler)
	picker.set_modes_visible(color_modes)
	picker.set_anchors_preset(preset,true)
