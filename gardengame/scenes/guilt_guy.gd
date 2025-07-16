extends "res://scenes/enemy.gd"

func _ready():
	super._ready()
	for i in 200:
		await get_tree().create_timer(0.05).timeout
		scale/=1.002
		var strength = 2 #* (i/200)
		$CollisionShape2D/AnimatedSprite2D.position = Vector2(randf_range(-strength, strength),randf_range(-strength, strength))
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalScript.game_state = 4
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	
		
func _update() ->void:
	$CollisionShape2D/AnimatedSprite2D.flip_h = (velocity.x>0)
	await get_tree().create_timer(randf()/2).timeout
	if randf()<movement_chance and not dead_man_walking:
		velocity = pathfindToVector(game_manager.player.global_position)
		if not $CollisionShape2D.get_node_or_null("mainSprite") == null:
			$CollisionShape2D/mainSprite.play("walk")
