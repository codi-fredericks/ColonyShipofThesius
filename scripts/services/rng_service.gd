extends Node

var seeded_rng: RandomNumberGenerator
var current_seed: int
var starting_state: int

var unseeded_rng: RandomNumberGenerator

func _ready() -> void:
	unseeded_rng = RandomNumberGenerator.new()
	self.randomize()

	if Constants.STARTING_SEED != 0:
		set_seed(Constants.STARTING_SEED)
	else:
		set_seed(unseeded_rng.randi())

func set_seed(new_seed: int) -> void:
	seeded_rng = RandomNumberGenerator.new()
	seeded_rng.seed = new_seed
	current_seed = new_seed
	starting_state = seeded_rng.state

func rand_weighted(weights: PackedFloat32Array, use_seeded: bool = true) -> int:
	var rng := _get_rng_source(use_seeded)

	return(rng.rand_weighted(weights))

func randf(use_seeded: bool = true) -> float:
	var rng := _get_rng_source(use_seeded)

	return(rng.randf())

func randf_range(from: float, to: float, use_seeded: bool = true) -> float:
	var rng := _get_rng_source(use_seeded)

	return(rng.randf_range(from, to))

func randfn(mean: float = 0.0, deviation: float = 1.0, use_seeded: bool = true) -> float:
	var rng := _get_rng_source(use_seeded)

	return(rng.randfn(mean, deviation))

func randi(use_seeded: bool = true) -> int:
	var rng := _get_rng_source(use_seeded)

	return(rng.randi())

func randi_range(from: int, to: int, use_seeded: bool = true) -> int:
	var rng := _get_rng_source(use_seeded)

	return(rng.randi_range(from, to))

func randomize() -> void:
	unseeded_rng.randomize()

func _get_rng_source(use_seeded: bool) -> RandomNumberGenerator:
	if use_seeded:
		return(seeded_rng)

	return(unseeded_rng)