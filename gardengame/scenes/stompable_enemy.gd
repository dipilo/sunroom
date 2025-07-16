extends "res://scenes/enemy.gd"

func _init():
	movement_chance = 0.6

func _on_collisioned(area: Area2D) -> void:
	if area.name == "PlayerArea":
		die()
	else:
		game_manager._damage_centerpiece(1)
		die()

func _physics_process(delta):
	super._physics_process(delta)
	$CollisionShape2D/mainSprite.flip_h = (velocity.x<0)
	if velocity.length()<10 and not dead_man_walking:
		$CollisionShape2D/mainSprite.play("idle")
func die():
	dead_man_walking = true
	game_manager.player.speed = 50
	$CollisionShape2D/mainSprite.play("die")
	if not get_tree() == null:
		await get_tree().create_timer(0.3).timeout
	game_manager.player.speed = 200
	#await get_tree().create_timer(0.1).timeout
	super.die()
	
