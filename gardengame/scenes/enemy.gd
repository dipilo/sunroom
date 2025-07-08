extends CharacterBody2D

var location = Vector2(0,0)
var game_manager
func _ready() ->void:
	if GlobalScript.gamemanger != null:
		GlobalScript.gamemanger.enemyList.append(self)
		game_manager=GlobalScript.gamemanger
	else:
		await get_tree().process_frame
		GlobalScript.gamemanger.enemyList.append(self)
		game_manager=GlobalScript.gamemanger

func _update() ->void:
	var target_direction = pathfindToVector(Vector2(10,10))
	move_to(location+target_direction)
func pathfindToVector(target: Vector2) -> Vector2:
	
	if target == location:
		return Vector2(0,0)
		
	var best_vector = Vector2(0,0)
	var best_distance = INF
	var directions = [
	Vector2(0, -1),
	Vector2(0, 1),
	Vector2(-1, 0),
	Vector2(1, 0)
	]
	for direction in directions:
		var sample_location = Vector2(location.y+direction.y,location.x+direction.x)
		var sample_distance = target.distance_to(sample_location)
		if sample_distance < best_distance:
			best_distance = sample_distance
			best_vector = direction
	return best_vector
func move_to(new_location: Vector2):
	global_position = game_manager.board.grid[new_location.y][new_location.x].get_node("center").global_position
	location = new_location
func animate():
	print("moved")
