extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	if OS.has_feature("web"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		get_tree().quit()

func _on_play_pressed() -> void:
	$AnimationPlayer.play("open_new_game")

func _on_credits_pressed() -> void:
	$AnimationPlayer.play("open_credits")


func _on_credits_text_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))


func _on_credit_close_pressed() -> void:
	$AnimationPlayer.play_backwards("open_credits")


func _on_new_game_close_pressed() -> void:
	$AnimationPlayer.play_backwards("open_new_game")

func _on_settings_pressed() -> void:
	update_settings_display()
	$AnimationPlayer.play("open_settings")
	


func _on_settings_close_pressed() -> void:
	Global.apply_settings()
	$AnimationPlayer.play_backwards("open_settings")

func update_config(config:GameModePreset = null):
	if config:
		%break_events.button_pressed = config.break_events
		%resource_events.button_pressed = config.resource_events
		%route_events.button_pressed = config.route_events
		%stop_count.value = config.stops
		%stop_count_label.text = "Journey Stops: %s" % str(config.stops)


func _on_option_button_item_selected(index: int) -> void:
	match %gamemode.get_item_id(index):
		0:
			update_config(Constants.GAMEMODE_PRESETS["easy"])
			%block.show()
		1:
			update_config(Constants.GAMEMODE_PRESETS["medium"])
			%block.show()
		2:
			update_config(Constants.GAMEMODE_PRESETS["hard"])
			%block.show()
		3:
			%block.hide()


func _on_stop_count_value_changed(value: int) -> void:
	%stop_count_label.text = "Journey Stops: %s" % str(value)


func _on_new_game_start_pressed() -> void:
	Global.game_event_break = %break_events.button_pressed
	Global.game_event_resource = %resource_events.button_pressed
	Global.game_event_route = %route_events.button_pressed
	Global.game_stops = %stop_count.value
	
	Global.scene_manager.change_gui_scene("")
	Global.scene_manager.change_world_2d_scene("res://game.tscn")


func _on_reset_settings_pressed() -> void:
	Global.colors = load("res://resources/palettes/matriax8c.tres")
	update_settings_display()
	Global.apply_settings()



func _on_settings_save_pressed() -> void:
	
	Global.audio_master = %audio_master.value/100
	Global.audio_sfx = %audio_sfx.value/100
	Global.audio_music = %audio_music.value/100
	var palette = ColorPalette.new()
	palette.colors = PackedColorArray([
	%color_background.color,
	%color_disabled.color,
	%color_font.color,
	%color_not_original.color,
	%color_broken.color,
	%color_damaged.color,
	%color_nominal.color,
	%color_upgraded.color
		])
	print(palette.colors)
	Global.colors = palette
	Global.apply_settings()
	_on_settings_close_pressed()

func update_settings_display() -> void:
	%color_background.color = Global.colors.colors[0]
	%color_disabled.color = Global.colors.colors[1]
	%color_font.color = Global.colors.colors[2]
	%color_not_original.color = Global.colors.colors[3]
	%color_broken.color = Global.colors.colors[4]
	%color_damaged.color = Global.colors.colors[5]
	%color_nominal.color = Global.colors.colors[6]
	%color_upgraded.color = Global.colors.colors[7]
	%audio_master.value = Global.audio_master*100
	%audio_sfx.value = Global.audio_sfx*100
	%audio_music.value = Global.audio_music*100
