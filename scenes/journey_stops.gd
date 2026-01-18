@tool
extends HBoxContainer

@export var stops:Array[Event]
@export var current_position:int = -1
@export var search_ahead:int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_stops()

func update_stops():
	for child in self.get_children():
		child.queue_free()
	var idx:int = 0
	for stop in stops:
		if idx == 0:
			idx+=1
			continue
		if !stop:
			continue
		var marker = TextureRect.new()
		marker.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		marker.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		marker.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		if idx <= current_position+search_ahead:
			marker.texture = load(Constants.ICONS[stop.category])
		else:
			marker.texture = load(Constants.ICONS["unknown"])
		self.add_child(marker)
		#if idx < len(stops)-1:
			#var spacer = Control.new()
			#spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			#self.add_child(spacer)
		idx += 1
		
