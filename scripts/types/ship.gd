class_name Ship
extends ShipData

signal system_damaged(system: String, delta: int)
signal system_recovered(system: String, delta: int)

var _max_stat: int = 4
var _min_stat: int = 0

@warning_ignore_start("unused_private_class_variable")
var _sensors_orig: bool = true
var _shields_orig: bool = true
var _weapons_orig: bool = true
var _refinery_orig: bool = true
var _navigation_orig: bool = true
var _science_orig: bool = true
@warning_ignore_restore("unused_private_class_variable")

static func new_ship() -> Ship:
	var this_ship = Ship.new()

	this_ship._sensors = 2
	this_ship._shields = 2
	this_ship._weapons = 2
	this_ship._refinery = 2
	this_ship._navigation = 2
	this_ship._science = 2

	return(this_ship)

func is_original(system: String) -> bool:
	if system not in Constants.SYSTEM_NAMES:
		push_error("Invalid system accessed: %s" % system)

	var originality_var = "_" + system + "_orig"

	return(get(originality_var))

func affect_system(system: String, delta: int) -> void:
	if delta == 0:
		return

	if system not in Constants.SYSTEM_NAMES:
		push_error("Invalid system accessed: %s" % system)

	var system_var: String = "_" + system

	var current_value = get(system_var)
	var new_value = clamp(current_value + delta, _min_stat, _max_stat)

	if current_value == new_value:
		return

	delta = new_value - current_value
	set(system_var, new_value)

	if delta < 0:
		system_damaged.emit(system, abs(delta))
		return

	system_recovered.emit(system, delta)

	if system == "trip_length":
		return

	change_originality(system, false)

func change_originality(system: String, new_state: bool) -> void:
	if system not in Constants.SYSTEM_NAMES:
		push_error("Invalid system accessed: %s" % system)

	var originality_var = "_" + system + "_orig"

	set(originality_var, new_state)

func meets_requirements(requirement: ShipData) -> bool:
	for system in Constants.SYSTEM_NAMES:
		var this_requirement: int = requirement.get_system(system)
		if this_requirement == 0:
			continue

		if get_system(system) < this_requirement:
			return(false)

	return(true)

func add_effect(effect: ShipData) -> void:
	print("New Values: ")
	for system in Constants.SYSTEM_NAMES:
		affect_system(system, effect.get_system(system))
		print("   %s: %s" % [system, get_system(system)])