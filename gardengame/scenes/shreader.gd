extends Node2D


@export var times_required = 3
var game_manager
func _ready() -> void:
	await get_tree().process_frame
	GlobalScript.gamemanger.shreader = self
	game_manager=GlobalScript.gamemanger


func _shreader_collided_with(area: Area2D) -> void:
	game_manager.player._paper(false)
	times_required-=1
	if times_required == 0:
		GlobalScript.game_state = 2
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
