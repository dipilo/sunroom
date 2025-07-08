extends "res://scenes/enemy.gd"


func _on_collisioned(area: Area2D) -> void:
	die()
