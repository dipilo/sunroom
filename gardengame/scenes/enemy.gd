extends CharacterBody2D

var game_manager
@export var speed = 200
@export var friction = 1.1
@export var random_movement = 30
var movement_chance = 1
func _ready() ->void:
	if GlobalScript.gamemanger != null:
		GlobalScript.gamemanger.enemyList.append(self)
		game_manager=GlobalScript.gamemanger
	else:
		await get_tree().process_frame
		GlobalScript.gamemanger.enemyList.append(self)
		game_manager=GlobalScript.gamemanger
	
func _update() ->void:
	await get_tree().create_timer(randf()/2).timeout
	if randf()<movement_chance:
		velocity = pathfindToVector(Vector2(260,260))


func pathfindToVector(target: Vector2) -> Vector2:
	
	var best_vector = (target - global_position).normalized()
	
	var random_angle = randf_range(-random_movement,random_movement)
	var rotated_direction = best_vector.rotated(deg_to_rad(random_angle))
	var random_magnitude = randf_range(0.5, 1)
	return Vector2(lerpf(best_vector.x, rotated_direction.x, random_magnitude) * speed, lerpf(best_vector.y, rotated_direction.y, random_magnitude) * speed) * game_manager.enemy_speed_mod
func die():
	game_manager.enemyList.erase(self)
	queue_free()
	
func _physics_process(delta):
	velocity/=friction
	move_and_slide()
