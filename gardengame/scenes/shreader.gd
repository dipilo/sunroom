extends Node2D

@export var shreading_time = 10.0
@export var seconds_required = 60.0
@export var noise_per_second = 0.02
var game_manager
var player_input = false
func _ready() -> void:
	await get_tree().process_frame
	GlobalScript.gamemanger.shreader = self
	game_manager=GlobalScript.gamemanger
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float):
	if player_input:
		game_manager.noise+=noise_per_second*delta
		seconds_required-=delta
		print(seconds_required)
		if seconds_required < 0:
			GlobalScript.game_state = 2
			get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
			

func _shreader_collided_with(area: Area2D) -> void:
	if not player_input:
		player_input = true
		$AnimatedSprite2D.play("active")
	else:
		player_input = false
		$AnimatedSprite2D.play("idle")
