class_name ScreenShaker
extends Camera2D

# Root 2D Node (Rotate this instead of the camera because we need to rotate child controls)
@export var target: Node2D

@export_category("Shake Settings")
@export var max_roll: float = 0.03
@export var max_offset: float = 8.0
@export var shake_time: float = 0.2
@export var noise_sample_speed: float = 1.7

@export_category("Shake Recovery")
@export var shake_decay: float = 5.0
@export var camera_recover_rate: float = 6.0

var noise = FastNoiseLite.new()

var _noise_sample: float = 0.0
var _shake_time_remaining: float = 0.0
var _shake_intensity: float = 0.0


func _physics_process(delta: float) -> void:
	if _shake_time_remaining > 0:
		_noise_sample += delta * noise_sample_speed
		_shake_time_remaining -= delta

		offset = Vector2(
			noise.get_noise_2d(_noise_sample, 0) * _shake_intensity,
			noise.get_noise_2d(0, _noise_sample) * _shake_intensity
		)

		target.rotation = noise.get_noise_2d(_noise_sample, _noise_sample) * max_roll

		_shake_intensity = max(_shake_intensity - shake_decay * delta, 0)

	else:
		offset = lerp(offset, Vector2.ZERO, camera_recover_rate * delta)
		target.rotation = lerp(rotation, 0.0, camera_recover_rate * delta)


func shake() -> void:
	noise.seed = RngService.randi(false)
	noise.frequency = 2.0

	_shake_intensity = max_offset
	_shake_time_remaining = shake_time
	_noise_sample = 0.0