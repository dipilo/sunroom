extends Node2D
@export var health = 3
func _ready():
	await get_tree().process_frame
	await get_tree().process_frame
	#haha mojang would never do this
	GlobalScript.gamemanger.centerpiece = self 
func _deal_damage(amt: int):
	health -= amt
	print(health)
	if health == 0:
		GlobalScript.game_state = 3
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
