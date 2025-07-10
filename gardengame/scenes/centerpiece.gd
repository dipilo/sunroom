extends Node2D
@export var health = 5
var z_part = load("res://scenes/z_particle.tscn")
var zs = []
func _ready():
	await get_tree().process_frame
	await get_tree().process_frame
	#haha mojang would never do this
	GlobalScript.gamemanger.centerpiece = self
func _deal_damage(amt: int):
	health -= amt
	print(health)
	if zs.get(1) == null:
		var a = null
		a.kill()
	else:
		pass
		#var dead_guy = zs.get(0)
		#zs.remove_at(0)
		#dead_guy.queue_free()
