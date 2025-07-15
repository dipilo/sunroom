extends Node2D
@export var correct_area : Area2D
var isPlayerInArea = false
var areas = {}
var rounds = 3
func _ready():
	areas = {"down":$quad_master/Node2D,"up":$quad_master/Node2D2,"right":$quad_master/Node2D3,"left":$quad_master/Node2D4,}
	while rounds > 0:
		var outcome = await play_round()
		if outcome:
			rounds-=1
		else:
			rounds = -1
	if rounds==-1:
		for i in 40:
			await get_tree().create_timer(0.15).timeout
			position.y-=10
			$"AnimatedSprite2D/game status".position.y+=5
		GlobalScript.gamemanger._spawn_angry_gameshow()
		self.queue_free()
	else:
		for i in 50:
			await get_tree().create_timer(0.1).timeout
			position.y-=10
		self.queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	isPlayerInArea = true
func shake(length : int):
	var original = $AnimatedSprite2D.position
	for i in length:
		var strength = 15
		await get_tree().create_timer(0.05).timeout
		$AnimatedSprite2D.position = Vector2(randf_range(-strength, strength),randf_range(-strength, strength))+original
	$AnimatedSprite2D.position = original
func play_round():
	var selected_direction = areas.keys().pick_random()
	var selected_node = areas.get(selected_direction)
	$quad_master/Area2D.global_position = selected_node.global_position
	await get_tree().create_timer(0.5).timeout
	$"AnimatedSprite2D/game status".text = "Go"
	shake(2)
	await get_tree().create_timer(0.5).timeout
	$"AnimatedSprite2D/game status".text = ""
	await get_tree().create_timer(0.5).timeout
	shake(2)
	$"AnimatedSprite2D/game status".text = "To"
	await get_tree().create_timer(0.5).timeout
	$"AnimatedSprite2D/game status".text = ""
	await get_tree().create_timer(1).timeout
	$quad_master/Sprite2D.visible = true
	$quad_master/Sprite2D2.visible = true
	for i in 10:
		await get_tree().create_timer(0.1).timeout
		$quad_master/Sprite2D.visible = false
		$quad_master/Sprite2D2.visible = false
		$"AnimatedSprite2D/game status".text = selected_direction
		shake(1)
		await get_tree().create_timer(0.1).timeout
		$"AnimatedSprite2D/game status".text = ""
		$quad_master/Sprite2D.visible = true
		$quad_master/Sprite2D2.visible = true
	if isPlayerInArea:
		await get_tree().create_timer(0.5).timeout
		for i in 5:
			await get_tree().create_timer(0.1).timeout
			$quad_master/Sprite2D.visible = true
			$quad_master/Sprite2D2.visible = true
			$"AnimatedSprite2D/game status".text = ""
			await get_tree().create_timer(0.1).timeout
			$"AnimatedSprite2D/game status".text = "GOOD"
			$quad_master/Sprite2D.visible = false
			$quad_master/Sprite2D2.visible = false
		$"AnimatedSprite2D/game status".text = ""
		return true
	else:
		await get_tree().create_timer(0.5).timeout
		$quad_master/Sprite2D.visible = false
		$quad_master/Sprite2D2.visible = false
		$"AnimatedSprite2D/game status".text = "FAILURE"
		$AnimatedSprite2D.play("failure")
		shake(5)
		GlobalScript.gamemanger.noise+=0.5
		#await get_tree().create_timer(0.5).timeout
		#$"AnimatedSprite2D/game status".text = ""
		return false

func _on_area_2d_area_exited(area: Area2D) -> void:
	isPlayerInArea = false
