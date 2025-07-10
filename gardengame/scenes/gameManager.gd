extends Node2D
@export var enemy_classes = ["res://scenes/squash_enemy.tscn","res://scenes/circle_enemy.tscn"]
@export var spawn_speed = 1
@export var enemy_speed_mod = 1
var diag_enemy_spawns = [Vector2(64,-20),
Vector2(466,-20),
Vector2(64,540),
Vector2(466,540),
Vector2(-20,64),
Vector2(-20,466),
Vector2(540,64),
Vector2(540,466),
]
var enemyList = []
var board
var centerpiece
var player
func _ready() -> void:
	GlobalScript.gamemanger = self
	await get_tree().process_frame
	board = GlobalScript.board
	$spawnTimer.wait_time = spawn_speed
	$spawnTimer.start()
func _game_loop() -> void:
	for enemy in enemyList:
		if is_instance_valid(enemy):
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
	var guy_instance = load(enemy_classes.pick_random()).instantiate()
	guy_instance.global_position = diag_enemy_spawns.pick_random()
	add_child(guy_instance)
	enemyList.append(guy_instance)

func _damage_centerpiece(amt: int):
	if not centerpiece == null:
		centerpiece._deal_damage(amt)
