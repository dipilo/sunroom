extends Node2D
@export var times_required = 3
var game_manager

func _ready() -> void:
	await get_tree().process_frame
	game_manager=GlobalScript.gamemanger



func _paper_stack_collided(area: Area2D) -> void:
	if game_manager.player.has_paper == false:
		game_manager.player._paper(true)
