extends Node

var palette: ColorPalette

func _ready() -> void:
	if not palette:
		change_palette(Constants.DEFAULT_PALETTE)

func change_palette(new_palette: ColorPalette) -> void:
	palette = new_palette
	update_colors()

func update_colors() -> void:
	RenderingServer.set_default_clear_color(palette.colors[Constants.BG_COLOR_IDX])

func get_system_color(system_value: int) -> Color:
	return(palette.colors[Constants.SYSTEM_STATUS_COLORS[system_value]])

func get_disabled_color() -> Color:
	return(palette.colors[Constants.DISABLED_COLOR_IDX])