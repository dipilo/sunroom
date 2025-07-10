extends Node2D
@export var health = 5
func _ready():
	await get_tree().process_frame
	await get_tree().process_frame
	#haha mojang would never do this
	GlobalScript.gamemanger.centerpiece = self

func _deal_damage(amt: int):
	health -= amt
	print(health)
