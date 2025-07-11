extends Control


func _enter_lvl1() -> void:
	get_tree().change_scene_to_file("res://scenes/battlefield.tscn")
	#get_tree().change_scene(load("res://scenes/battlefield.tscn"))
