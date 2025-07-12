extends Node2D

@export var shreading_time = 10.0
@export var times_required = 3
var game_manager
var is_busy = false
func _ready() -> void:
	await get_tree().process_frame
	GlobalScript.gamemanger.shreader = self
	game_manager=GlobalScript.gamemanger
	$AnimatedSprite2D.play("idle")

func _shreader_collided_with(area: Area2D) -> void:
	if game_manager.player.has_paper and not is_busy:
		is_busy = true
		game_manager.player._paper(false)
		$AnimatedSprite2D.play("active")
		await get_tree().create_timer(shreading_time).timeout
		$AnimatedSprite2D.play("idle")
		times_required-=1
		is_busy = false
		if times_required == 0:
			GlobalScript.game_state = 2
			get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
