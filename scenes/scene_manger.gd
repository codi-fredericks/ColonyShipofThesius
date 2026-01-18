class_name SceneManager extends Node

@export var world_3d:Node3D
@export var world_2d:Node2D
@export var gui:Control
@export var SceneTransition: SceneTransitionController

var current_3d_scene
var current_2d_scene
var current_gui_scene

func _ready() -> void:
	Global.scene_manager = self
	current_gui_scene = $GUI/SplashScreen

func change_gui_scene(
	new_scene:String,
	delete:bool=true,
	keep_running:bool=false,
	transition:bool=true,
	transition_in:String = "FadeIn",
	transition_out:String = "FadeOut",
	seconds:float = 1.0
	) -> void:
	if transition:
		SceneTransition.transition(transition_out, seconds)
		await SceneTransition.animation_player.animation_finished
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	var new = load(new_scene)
	if new == null:
		return
	new = new.instantiate()
	gui.add_child(new)
	current_gui_scene = new
	if transition:
		SceneTransition.transition(transition_in, seconds)

func change_world_3d_scene(
	new_scene:String,
	delete:bool=true,
	keep_running:bool=false,
	transition:bool=true,
	transition_in:String = "FadeIn",
	transition_out:String = "FadeOut",
	seconds:float = 1.0
	) -> void:
	if transition:
		SceneTransition.transition(transition_out, seconds)
		await SceneTransition.animation_player.animation_finished
	if current_3d_scene != null:
		if delete:
			current_3d_scene.queue_free()
		elif keep_running:
			current_3d_scene.visible = false
		else:
			world_3d.remove_child(current_3d_scene)
	var new = load(new_scene)
	if new == null:
		return
	new = new.instantiate()
	world_3d.add_child(new)
	current_3d_scene = new
	if transition:
		SceneTransition.transition(transition_in, seconds)

func change_world_2d_scene(
	new_scene:String,
	delete:bool=true,
	keep_running:bool=false,
	transition:bool=true,
	transition_in:String = "FadeIn",
	transition_out:String = "FadeOut",
	seconds:float = 1.0
	) -> void:
	if transition:
		SceneTransition.transition(transition_out, seconds)
		await SceneTransition.animation_player.animation_finished
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			current_2d_scene.visible = false
		else:
			world_2d.remove_child(current_2d_scene)
	var new = load(new_scene)
	if new == null:
		return
	new = new.instantiate()
	world_2d.add_child(new)
	current_2d_scene = new
	if transition:
		SceneTransition.transition(transition_in, seconds)


func _on_full_screen_pressed() -> void:
	var mode := DisplayServer.window_get_mode()
	var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
	$full_screen.text = "Full Screen: off" if is_window else "Full Screen: on"
