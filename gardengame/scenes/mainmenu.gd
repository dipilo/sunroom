extends Control
@export var levels = []
func _ready():
	match GlobalScript.game_state:
		0:
			$"game status".text = "Select Level"
		1:
			$"game status".text = "this text should never appear. If you see this, something has gone wrong"
		2:
			$"game status".text = "You Win! Play Again?"
		3:
			$"game status".text = "You Lose! Play Again?"
		4:
			$"game status".text = "CONSUMED BY GUILT"


func _enter_lvl1() -> void:
	GlobalScript.game_state = 1
	get_tree().change_scene_to_file("res://scenes/battlefield.tscn")


func _enter_lvl2() -> void:
	pass # Replace with function body.


func _enter_lvl3() -> void:
	pass # Replace with function body.
