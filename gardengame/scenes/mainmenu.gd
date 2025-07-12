extends Control

func _ready():
	match GlobalScript.game_state:
		0:
			$"game status".text = "Select Level"
		1:
			$"game status".text = "this should never happen"
		2:
			$"game status".text = "You Win! Play Again?"
		3:
			$"game status".text = "You Lose! Play Again?"


func _enter_lvl1() -> void:
	GlobalScript.game_state = 1
	get_tree().change_scene_to_file("res://scenes/battlefield.tscn")
