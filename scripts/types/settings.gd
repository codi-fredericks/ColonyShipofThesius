class_name SavedSettings extends Resource

@export var audio_master:float = 1
@export var audio_sfx:float = 1
@export var audio_music:float = 1
@export var colors: ColorPalette

func save_settings():
	ResourceSaver.save(self, "user://settings.tres")

static func load_settings() -> SavedSettings:
	var setting = load("user://settings.tres")
	if setting:
		return setting
	else:
		return SavedSettings.new()
