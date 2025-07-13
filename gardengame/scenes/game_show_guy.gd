extends Node2D
@export var correct_area : Area2D
var isPlayerInArea = false
var areas = {}

func _ready():
	areas = {"down":$quad_master/Node2D,"up":$quad_master/Node2D2,"right":$quad_master/Node2D3,"left":$quad_master/Node2D4,}
	play_round()

func _on_area_2d_area_entered(area: Area2D) -> void:
	isPlayerInArea = true
	
func play_round():
	var selected_direction = areas.keys().pick_random()
	var selected_node = areas.get(selected_direction)
	$quad_master/Area2D.global_position = selected_node.global_position
	await get_tree().create_timer(0.5).timeout
	$"AnimatedSprite2D/game status".text = "Go"
	await get_tree().create_timer(0.5).timeout
	$"AnimatedSprite2D/game status".text = ""
	await get_tree().create_timer(0.5).timeout
	$"AnimatedSprite2D/game status".text = "To"
	await get_tree().create_timer(0.5).timeout
	$"AnimatedSprite2D/game status".text = ""
	await get_tree().create_timer(1).timeout
	$quad_master/Sprite2D.visible = true
	$quad_master/Sprite2D2.visible = true
	for i in 10:
		await get_tree().create_timer(0.1).timeout
		$"AnimatedSprite2D/game status".text = selected_direction
		await get_tree().create_timer(0.1).timeout
		$"AnimatedSprite2D/game status".text = ""

func _on_area_2d_area_exited(area: Area2D) -> void:
	isPlayerInArea = false
