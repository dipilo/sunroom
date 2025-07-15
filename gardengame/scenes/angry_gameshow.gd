extends "res://scenes/enemy.gd"

func _init():
	movement_chance = 1
	speed = 500
func _on_timer_timeout() -> void:
	$CollisionShape2D/AnimatedSprite2D.position = Vector2(randf_range(-5, 5),randf_range(-5, 5))
func _on_collisioned(area: Area2D) -> void:
	if area.name == "PlayerArea":
		pass
	else:
		game_manager._damage_centerpiece(1)
		await get_tree().create_timer(0.5).timeout
		game_manager.noise+=0.2
		die()
		
