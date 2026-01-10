extends Node

# Gameplay
const SYSTEM_NAMES: Array[String] = [
	"sensors",
	"shields",
	"weapons",
	"refinery",
	"navigation",
	"science",
]

const INITIAL_TRIP_LENGTH: int = 10

const BREAK_EVENT_FOLDER: String = "res://resources/events/break_events/"
const RESOURCE_EVENT_FOLDER: String = "res://resources/events/resource_events/"
const ROUTE_EVENT_FOLDER: String = "res://resources/events/route_events/"

const STARTING_SEED: int = 0

# Graphics
const BG_COLOR := Color("#101820")

# Audio
const SFX_LIBRARY: SfxLib = preload("res://resources/sfx_library.tres") as SfxLib
const MAX_PLAYERS_PER_SFX: int = 4
const SFX_BUS: StringName = &"SFX"
const BGM_BUS: StringName = &"Music"

func _enter_tree() -> void:
	RenderingServer.set_default_clear_color(BG_COLOR)