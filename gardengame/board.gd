extends Node2D
var grid = []
var grid_box = preload("res://scenes/gridbox.tscn")
var game_manager
func _ready():
	await get_tree().process_frame
	GlobalScript.gamemanger.board = self
	game_manager=GlobalScript.gamemanger
	GlobalScript.board = self
	for i in range(21):
		grid.append([])
		for j in range(21):
			var grid_instance = grid_box.instantiate()
			grid_instance.position = Vector2(i*40,j*40)
			grid[i].append(grid_instance)
			add_child(grid_instance)
		
