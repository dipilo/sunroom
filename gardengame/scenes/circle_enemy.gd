extends "res://scenes/enemy.gd"
var center_node = self
var previous_angle = 0.0
var accumulated_angle = 0.0
var full_circle_threshold = 2 * PI

func _init():
	movement_chance = 0.3
func _ready():
	super._ready()
	previous_angle = get_current_angle()
	

func _physics_process(delta):
	super._physics_process(delta)
	var current_angle = get_current_angle()
	var delta_angle = wrapf(current_angle - previous_angle, -PI, PI)
	accumulated_angle += delta_angle
	previous_angle = current_angle

	if abs(accumulated_angle) >= full_circle_threshold:
		die()
		accumulated_angle = 0.0
		
func get_current_angle() -> float:
	var to_player = game_manager.player.global_position - center_node.global_position
	return atan2(to_player.y, to_player.x)
