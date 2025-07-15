extends Node2D
@export var default_enemy_waves = { #key is number of times the enemy should spawn each "cycle"
	"res://scenes/squash_enemy.tscn" : 2,
	"res://scenes/circle_enemy.tscn" : 1
}
@export var amount_of_gameshow = 30
@export var difficulty = 1 #general difficulty tweaking
var curr_enemy_waves = []
@export var wave_cooldown = 5.0
@export var enemy_speed_mod = 1
@export var big_guy_frequency = 30
var i = 0
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
var shreader
var noise = 0.0 #1 = max noise
func _ready() -> void:
	GlobalScript.gamemanger = self
	await get_tree().process_frame
	board = GlobalScript.board
	setup_next_wave()
	$spawnTimer.wait_time = wave_cooldown
	$spawnTimer.start()
	await get_tree().create_timer(1).timeout
	while amount_of_gameshow > 0:
		if true:
			await get_tree().create_timer(log(big_guy_frequency+difficulty)*10).timeout
			var guy = load("res://scenes/game_show_guy.tscn").instantiate()
			amount_of_gameshow-=1
			big_guy_frequency*=1.2
			add_child(guy)
func _game_loop() -> void:
	for enemy in enemyList:
		if is_instance_valid(enemy):
			enemy._update()

func _spawn_timer_timeout() -> void:
	await get_tree().create_timer(randf()).timeout #wait for between 0 and 1 seconds, to add some randomness

	if curr_enemy_waves.size() == 0:
		setup_next_wave()
	
	var curr_guy = curr_enemy_waves.get(0)
	curr_enemy_waves.remove_at(0)
	
	var count = 1
	if curr_guy == "res://scenes/squash_enemy.tscn":
		count = int(randf()*2+2+difficulty)
	for i in count:
		var guy_instance = load(curr_guy).instantiate()
		guy_instance.global_position = diag_enemy_spawns.pick_random()
		add_child(guy_instance)
		enemyList.append(guy_instance)

func _damage_centerpiece(amt: int):
	if not centerpiece == null:
		centerpiece._deal_damage(amt)

func setup_next_wave():
	curr_enemy_waves = []
	for key in default_enemy_waves.keys():
		var count = int(default_enemy_waves[key])
		for i in count:
			curr_enemy_waves.append(key)
	curr_enemy_waves.shuffle()
	$spawnTimer.wait_time*=0.98
	
func _physics_process(delta: float):
	i+=0.1/delta
	if noise>1:
		noise = 1
	noise*=0.999
	$noiseNode/Sprite2D.scale = Vector2(1.5-(noise/2),1.5-(noise/2))+(Vector2(sin(i),sin(i))/1000)
	$noiseNode/Sprite2D.self_modulate.a = noise
func _spawn_angry_gameshow():
	var guy = load("res://scenes/angry_gameshow.tscn").instantiate()
	guy.global_position = diag_enemy_spawns.pick_random()
	add_child(guy)
	
