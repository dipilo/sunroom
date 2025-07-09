extends Node2D
@export var enemy_classes = []
@export var spawn_speed = 3
@export var enemy_speed_mod = 1
var enemyList = []
var board
func _ready() -> void:
	GlobalScript.gamemanger = self
	await get_tree().process_frame
	#await get_tree().process_frame
	board = GlobalScript.board
	$spawnTimer.wait_time = spawn_speed
	$spawnTimer.start()
func _game_loop() -> void:
	for enemy in enemyList:
		enemy._update()


func _spawn_timer_timeout() -> void:
	await get_tree().create_timer(randf()).timeout #wait for between 0 and 0.99999 seconds, to add some randomness
	var hasFoundValidSpawnTile = false
	var spawn_tile
	var check_tile = board.edge_tiles.pick_random()
	while not hasFoundValidSpawnTile:
		if not check_tile.occupied:
			hasFoundValidSpawnTile = true
			spawn_tile = check_tile
		else:
			check_tile = board.edge_tiles.pick_random()
	var guy_instance = preload("res://scenes/squash_enemy.tscn").instantiate()
	#TODO MAKE GUY SPAWNNN
	add_child(guy_instance)
	enemyList.append(guy_instance)
