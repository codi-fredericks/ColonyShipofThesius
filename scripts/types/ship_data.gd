class_name ShipData
extends Resource

@warning_ignore_start("unused_private_class_variable")
@export var _sensors: int = 0
@export var _shields: int = 0
@export var _weapons: int = 0
@export var _refinery: int = 0
@export var _navigation: int = 0
@export var _science: int = 0
@warning_ignore_restore("unused_private_class_variable")

func get_system(system: String) -> int:
	if system not in Constants.SYSTEM_NAMES:
		push_error("Invalid system accessed: %s" % system)
		return(0)

	var system_var: String = "_" + system

	return(get(system_var))