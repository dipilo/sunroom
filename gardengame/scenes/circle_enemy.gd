extends "res://scenes/enemy.gd"
var center_node = self
var previous_angle = 0.0
var accumulated_angle = 0.0
var full_circle_threshold = 2 * PI
var time_to_chill = 5
var time_before_chill = 5
func _init():
	movement_chance = 0.4
func _ready():
	super._ready()
	#await get_tree().process_frame
	previous_angle = get_current_angle()
	
func _update():
	super._update()
		

func _physics_process(delta):
	super._physics_process(delta)
	var current_angle = get_current_angle()
	var delta_angle = wrapf(current_angle - previous_angle, -PI, PI)
	accumulated_angle += delta_angle
	previous_angle = current_angle
	if not game_manager.player == null:
		$CollisionShape2D/Node2D/Sprite2D3.position = (game_manager.player.global_position - $CollisionShape2D/Node2D.global_position ).normalized()*2
	if abs(accumulated_angle) >= full_circle_threshold:
		die()
		accumulated_angle = 0.0
		
func get_current_angle() -> float:
	if game_manager.player == null:
		return 0
	var to_player = game_manager.player.global_position - center_node.global_position
	return atan2(to_player.y, to_player.x)
