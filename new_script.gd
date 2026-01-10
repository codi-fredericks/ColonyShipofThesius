extends Node

#@export_category("Parts Varibles")
#@export var Sensors    : int = 2
#@export var Shields    : int = 2
#@export var Weapons    : int = 2
#@export var Refinery   : int = 2
#@export var Navigation : int = 2
#@export var Science    : int = 2

@export_category("Event Data")
@export var event_table : Array[event]
@export var current_event : event

func _ready() -> void:
	current_event = event_table.pick_random()
	
	$Event_Prompt.text = current_event.Prompt
	for option in current_event.option_text:
		var newbutton = Button.new()
		newbutton.text = option
		get_node("Buttons").add_child(newbutton)
