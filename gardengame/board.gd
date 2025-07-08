extends Node2D
var grid = []
var grid_box = preload("res://scenes/gridbox.tscn")
func _ready():
	
	for i in range(21):
		grid.append([])
		for j in range(21):
			var grid_instance = grid_box.instantiate()
			grid_instance.position = Vector2(i*20,j*20)
			grid[i].append(grid_instance)
			add_child(grid_instance)
		
