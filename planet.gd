@tool
extends Sprite2D

var time = 1000.0

func _process(delta: float) -> void:
	time += delta
	update_time(time)

func update_time(t: float) -> void:
	material.set_shader_parameter("time", t * get_multiplier(material) * 0.02)

func get_multiplier(mat: ShaderMaterial) -> float:
	return(round(mat.get_shader_parameter("size")) * 2.0) / mat.get_shader_parameter("time_speed")
