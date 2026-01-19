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

const STATUS: Dictionary[int,String] = {
	0: "res://assets/gfx/unknown.png",
	1: "res://assets/gfx/bad.png",
	2: "res://assets/gfx/neutral.png",
	3: "res://assets/gfx/good.png"
}

const ICONS: Dictionary[String,String] = {
	"unknown":"res://assets/gfx/unknown.png",
	"route":"res://assets/gfx/route.png",
	"resource":"res://assets/gfx/resources.png",
	"broken":"res://assets/gfx/broken.png"
}

const GAMEMODE_PRESETS: Dictionary[String,GameModePreset] = {
	"easy":preload("res://resources/gamemodes/easy.tres"),
	"medium":preload("res://resources/gamemodes/medium.tres"),
	"hard":preload("res://resources/gamemodes/hard.tres"),
	"custom":preload("res://resources/gamemodes/custom.tres")
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
