extends Node2D
@export var default_enemy_waves = { #key is number of times the enemy should spawn each "cycle"
	"res://scenes/squash_enemy.tscn" : 6,
	"res://scenes/circle_enemy.tscn" : 3,
	"res://scenes/Inverter_Enemy.tscn" : 1,
}
@export var big_guys = {
	"res://scenes/game_show_guy.tscn" : 40,
	"res://scenes/guilt_guy.tscn" : 80
}
@export var difficulty = 1 #general difficulty tweaking
var curr_enemy_waves = []
@export var wave_cooldown = 5.0
@export var enemy_speed_mod = 1
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
var inverterspawns = [Vector2(128,100),
Vector2(100,128),
Vector2(300,80),
Vector2(80,300),
Vector2(500,300),
Vector2(200,500)
]
var enemyList = []
var board
var centerpiece
var player
var shreader
var noise = 0.0 #1 = max noise
func _ready() -> void:
	$speakertimer.wait_time = 20
	GlobalScript.gamemanger = self
	await get_tree().process_frame
	board = GlobalScript.board
	setup_next_wave()
	$spawnTimer.wait_time = wave_cooldown
	$spawnTimer.start()
	await get_tree().create_timer(1).timeout
	for key in big_guys.keys():
		print(key)
		var time = int(big_guys[key])
		match key:
			"res://scenes/game_show_guy.tscn":
				game_show_spawning(time)
			"res://scenes/guilt_guy.tscn":
				guilt_spawning(time)
	
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
		if curr_guy == "res://scenes/Inverter_Enemy.tscn":
			guy_instance.global_position = inverterspawns.pick_random()
		add_child(guy_instance)
		enemyList.append(guy_instance)

func _damage_centerpiece(amt: int):
	$spark.scale/=1.4
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
	$spark.rotate(deg_to_rad(-0.002/delta))
	i+=0.1/delta
	if noise>1:
		noise = 0
		spawn_guy("res://scenes/sound_lady.tscn")
	noise*=0.9994
	$noiseNode/Sprite2D.scale = Vector2(1.5-(noise/2),1.5-(noise/2))+(Vector2(sin(i),sin(i))/1000)
	$noiseNode/Sprite2D.self_modulate.a = noise*.70
func spawn_guy(path:String):
	var guy = load(path).instantiate()
	if not path == "res://scenes/game_show_guy.tscn":
		guy.global_position = diag_enemy_spawns.pick_random()
	add_child(guy)
	


func _on_speakertimer_timeout() -> void:
	if $speaker.visible == true:
		return
	$speaker.visible = true
	$speaker.play("spawn")
	await get_tree().create_timer(0.8).timeout
	$speaker.play("idle")
	for i in 10:
		noise +=0.02
		await get_tree().create_timer(0.4).timeout
	$speaker.visible = false

func game_show_spawning(time : int):
	await get_tree().create_timer(time/2.5-randf()).timeout
	while true:
		spawn_guy("res://scenes/game_show_guy.tscn")
		await get_tree().create_timer(time).timeout
func guilt_spawning(time : int):
	
	await get_tree().create_timer(time/2.5-randf()).timeout
	while true:
		spawn_guy("res://scenes/guilt_guy.tscn")
		await get_tree().create_timer(time).timeout
