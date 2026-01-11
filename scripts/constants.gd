extends Node

# Gameplay
const SYSTEM_NAMES: Array[String] = [
	"sensors",
	"shields",
	"weapons",
	"refinery",
	"engines",
	"science",
]

const ABBREVIATIONS: Dictionary[String, String] = {
	"engines": "ENGN",
	"sensors": "SENS",
	"refinery": "REFN",
	"science": "SCIN",
	"shields": "SHLD",
	"weapons": "WEPN",
}

const INITIAL_TRIP_LENGTH: int = 10

const BREAK_EVENT_FOLDER: String = "res://resources/events/break_events/"
const RESOURCE_EVENT_FOLDER: String = "res://resources/events/resource_events/"
const ROUTE_EVENT_FOLDER: String = "res://resources/events/route_events/"

const STARTING_SEED: int = 0

# Graphics
const DEFAULT_PALETTE: ColorPalette = preload("res://resources/palettes/matriax8c.tres")
const BG_COLOR_IDX: int = 0
const FG_COLOR_IDX: int = 2
const DISABLED_COLOR_IDX: int = 1
const SYSTEM_STATUS_COLORS: Array[int] = [
	4,
	5,
	6,
	7,
]


# Audio
const SFX_LIBRARY: SfxLib = preload("res://resources/sfx_library.tres") as SfxLib
const MAX_PLAYERS_PER_SFX: int = 4
const SFX_BUS: StringName = &"SFX"
const BGM_BUS: StringName = &"Music"
