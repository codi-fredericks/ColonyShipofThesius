extends Node


var scene_manager: SceneManager


var game_stops:int = 10
var game_event_break:bool = true
var game_event_resource:bool = true
var game_event_route:bool = true

var audio_master:float = 1
var audio_sfx:float = 1
var audio_music:float = 1
var colors: ColorPalette = preload("res://resources/palettes/matriax8c.tres")
var settings:SavedSettings

func _ready() -> void:
	settings = SavedSettings.load_settings()
	audio_master = settings.audio_master
	audio_sfx = settings.audio_sfx
	audio_music = settings.audio_music
	if settings.colors:
		colors = settings.colors
	apply_settings()
	MusicManager.play_background()

func apply_settings():
	AudioServer.set_bus_volume_linear(0,audio_master)
	AudioServer.set_bus_volume_linear(1,audio_sfx)
	AudioServer.set_bus_volume_linear(2,audio_music)
	ColorManager.change_palette(colors)
	settings.save_settings()
