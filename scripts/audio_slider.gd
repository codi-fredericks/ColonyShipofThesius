extends HBoxContainer


@export var label_value:Label
@export var audio_bus:String

func on_change(value:float):
	label_value.text = "%s %%" % str(value)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(audio_bus), value/100)
