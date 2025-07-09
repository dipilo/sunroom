extends Node2D
var grid = []
var grid_box = preload("res://scenes/gridbox.tscn")
var game_manager
var edge_tiles = []
func _ready():
	await get_tree().process_frame
	GlobalScript.gamemanger.board = self
	game_manager=GlobalScript.gamemanger
	GlobalScript.board = self
	for i in range(13):
		grid.append([])
		for j in range(13):
			var grid_instance = grid_box.instantiate()
			grid_instance.position = Vector2(i*40,j*40)
			grid_instance.location = Vector2(i,j)
			grid[i].append(grid_instance)
			add_child(grid_instance)
	for i in range(13):
		edge_tiles.append(grid[0][i])
		edge_tiles.append(grid[i][0])
		edge_tiles.append(grid[12][i])
		edge_tiles.append(grid[i][12])
