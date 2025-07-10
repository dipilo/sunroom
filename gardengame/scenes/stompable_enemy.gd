extends "res://scenes/enemy.gd"

func _init():
	movement_chance = 0.6

func _on_collisioned(area: Area2D) -> void:
	if area.name == "PlayerArea":
		die()
	else:
		game_manager._damage_centerpiece(1)
		die()
