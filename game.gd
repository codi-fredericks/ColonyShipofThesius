class_name Game
extends Node2D

@export var screen_shaker: ScreenShaker
@export var control_root: Control
@export var event: Control

var ship: Ship

var break_events: Array[Event] = []
var resource_events: Array[Event] = []
var route_events: Array[Event] = []

var trip: Array[Event]
var trip_step: int = 0

func _ready() -> void:
	reset_end()
	$blocker.hide()
	ship = Ship.new_ship()
	
	if Global.game_event_break:
		break_events = _array_from_folder(Constants.BREAK_EVENT_FOLDER)
	else:
		break_events = []
	if Global.game_event_resource:
		resource_events = _array_from_folder(Constants.RESOURCE_EVENT_FOLDER)
	else:
		resource_events = []
	if Global.game_event_route:
		route_events = _array_from_folder(Constants.ROUTE_EVENT_FOLDER)
	else:
		route_events = []
	_on_viewport_resize()
	get_viewport().size_changed.connect(_on_viewport_resize)

	generate_trip()
	%JourneyStops.stops = trip
	%JourneyStops.current_position = trip_step
	%JourneyStops.search_ahead = ship.get_system(Constants.SYSTEM_NAMES[0]) > 2
	%JourneyStops.update_stops()
	
	%ship_token.progress_ratio = ((1.0/float(Global.game_stops+1)) * float(trip_step))

func remove_empty(value) -> bool:
	if value == [] or value == null:
		return false
	return true

func generate_trip() -> void:
	trip = []
	trip.append(load("res://resources/events/start.tres"))
	for i in range(Global.game_stops):
		if i == 4 and Global.game_event_resource:
			add_stop(resource_events)
		else:
			add_stop([break_events, resource_events, route_events].filter(remove_empty).pick_random())

func add_event_stop(count: int) -> void:
	for i in range(count):
		add_stop([break_events, resource_events].filter(remove_empty).pick_random())

func remove_event_stop(count: int) -> void:
	for i in range(count):
		trip.remove_at(randi_range(trip_step, trip.size()))

func add_stop(event_array: Array[Event]) -> void:
	var stop: Event = event_array.pick_random()
	if stop == null:
		push_error("NULL EVENT")
	trip.append(stop)
	event_array.erase(stop)

func get_current_event() -> Event:
	return(trip[trip_step])

func advance_trip() -> void:
	var parts_alive:int = len(Constants.SYSTEM_NAMES)
	for system in Constants.SYSTEM_NAMES:
		if ship.get_system(system) <= 0:
			parts_alive -= 1
	if parts_alive <= 0:
		lose()
		return
	
	trip_step += 1
	%JourneyStops.current_position = trip_step
	%JourneyStops.search_ahead = ship.get_system(Constants.SYSTEM_NAMES[0]) > 2
	%JourneyStops.update_stops()
	var tween = create_tween()
	$blocker.show()
	event.modulate = Color(1,1,1,0)
	tween.tween_property(%ship_token, "progress_ratio", ((1.0/float(len(trip))) * float(trip_step)), 0.5)
	await tween.finished
	if trip_step >= trip.size():
		print("OUT OF STEPS!")
		SfxService.play("win")
		trip_step = 0
		win()
	else:
		$blocker.hide()
		event.modulate = Color(1,1,1,1)
		event.get_next_event()

func _array_from_folder(folder: String) -> Array[Event]:
	var array: Array[Event] = []

	for file in ResourceLoader.list_directory(folder):
		if not file.ends_with(".tres"):
			continue

		var filepath: String = folder + file
		array.append(ResourceLoader.load(filepath))

	return(array)

func _on_viewport_resize() -> void:
	position = get_viewport_rect().size / 2
	control_root.custom_minimum_size = get_viewport_rect().size

func reset_end():
	$lose.hide()
	$win.hide()
	$lose/HBoxContainer.modulate = Color(1,1,1,0)
	$win/HBoxContainer.modulate = Color(1,1,1,0)

func lose():
	$lose.show()
	$lose/AnimationPlayer.play("ship_break")
	var tween = create_tween()
	tween.tween_interval(3)
	
	tween.parallel().tween_property($lose/HBoxContainer, "modulate", Color(1,1,1,1),1)
	tween.parallel().tween_property($lose/ColorRect, "modulate", Color(1,1,1,1),1)
	SfxService.play("lose")

func win():
	var original_parts:int = len(Constants.SYSTEM_NAMES)
	for system in Constants.SYSTEM_NAMES:
		if not ship.is_original(system):
			original_parts -= 1
	
	$win.show()
	$win/AnimationPlayer.play("landing")
	var tween = create_tween()
	tween.tween_interval(3)
	tween.parallel().tween_property($win/HBoxContainer, "modulate", Color(1,1,1,1),1)
	tween.parallel().tween_property($win/ColorRect, "modulate", Color(1,1,1,1),1)
	if original_parts > 0:
		SfxService.play("win")
		$win/ColorRect/text_good.show()
		$win/ColorRect/text_bad.hide()
	else:
		SfxService.play("lose")
		$win/ColorRect/text_good.hide()
		$win/ColorRect/text_bad.show()
func _on_main_menu_pressed() -> void:
	Global.scene_manager.change_world_2d_scene("")
	Global.scene_manager.change_gui_scene("res://main_menu.tscn")


func _on_replay_pressed() -> void:
	Global.scene_manager.change_world_2d_scene("res://game.tscn")
