extends "res://scenes/enemy.gd"

func _init():
	movement_chance = 0.0
	#position = Vector2(540, 466)
	
func _process(delta: float) -> void:
	game_manager.player.negetive = -1

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		die()
pass # Replace with function body.

   	 
func die():
	dead_man_walking = true

	game_manager.player.speed = 200
	game_manager.player.negetive = 1
	#game_manager.default_enemy_waves.add("res://scenes/Inverter_Enemy.tscn")
	super.die()
