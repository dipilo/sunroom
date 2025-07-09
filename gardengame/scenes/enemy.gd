extends CharacterBody2D

var game_manager
@export var speed = 200
@export var friction = 1.1
@export var random_movement = 30
func _ready() ->void:
	if GlobalScript.gamemanger != null:
		GlobalScript.gamemanger.enemyList.append(self)
		game_manager=GlobalScript.gamemanger
	else:
		await get_tree().process_frame
		GlobalScript.gamemanger.enemyList.append(self)
		game_manager=GlobalScript.gamemanger
	
func _update() ->void:
	velocity = pathfindToVector(Vector2(260,260))

func pathfindToVector(target: Vector2) -> Vector2:
	
	var best_vector = (target - global_position).normalized()
	
	var random_angle = randf_range(-random_movement,random_movement)
	var rotated_direction = best_vector.rotated(deg_to_rad(random_angle))
	var random_magnitude = randf_range(0.5, 1)
	return Vector2(lerpf(best_vector.x, rotated_direction.x, random_magnitude) * speed, lerpf(best_vector.y, rotated_direction.y, random_magnitude) * speed)
	
func move_to(new_location: Vector2):
	global_position = game_manager.board.grid[new_location.y][new_location.x].get_node("center").global_position
	game_manager.board.grid[new_location.y][new_location.x].occupied = true
	animate()

func animate():
	print("moved")

func die():
	game_manager.enemyList.erase(self)
	queue_free()
	
func _physics_process(delta):
	velocity/=friction
	move_and_slide()
