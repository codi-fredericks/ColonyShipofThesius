class_name Game
extends Node2D

@export var screen_shaker: ScreenShaker
@export var control_root: Control

var ship: Ship

var break_events: Array[Event] = []
var resource_events: Array[Event] = []
var route_events: Array[Event] = []

var trip: Array[Event]
var trip_step: int = 0

func _ready() -> void:
	ship = Ship.new_ship()

	break_events = _array_from_folder(Constants.BREAK_EVENT_FOLDER)
	resource_events = _array_from_folder(Constants.RESOURCE_EVENT_FOLDER)
	route_events = _array_from_folder(Constants.ROUTE_EVENT_FOLDER)

	_on_viewport_resize()
	get_viewport().size_changed.connect(_on_viewport_resize)

	generate_trip()


func generate_trip() -> void:
	for i in range(Constants.INITIAL_TRIP_LENGTH):
		if i == 5:
			add_stop(resource_events)
		else:
			add_stop(break_events)

func add_event_stop(count: int) -> void:
	for i in range(count):
		add_stop([break_events, resource_events].pick_random())

func remove_event_stop(count: int) -> void:
	for i in range(count):
		trip.remove_at(randi_range(trip_step, trip.size()))

func add_stop(event_array: Array[Event]) -> void:
	var stop: Event = event_array.pick_random()
	trip.append(stop)
	event_array.erase(stop)

func get_current_event() -> Event:
	return(trip[trip_step])

func advance_trip() -> void:
	trip_step += 1
	if trip_step >= trip.size():
		print("OUT OF STEPS!")
		trip_step = 0

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