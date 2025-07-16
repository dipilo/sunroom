extends "res://scenes/enemy.gd"

var mirrorself
var ismirror = false
var guyx = 0
var guyy = 0
var guy_instance2
var alreadycloned = false

func _init():
	movement_chance = 1

func _process(delta: float) -> void:
	if ismirror == false:
		nomirrors()
	if ismirror == true:
		yesmirrors()
	if ismirror == false && alreadycloned == false:
		guy_instance2 = self.duplicate()
	if global_position.x == 466:
		guyx = 64
	if global_position.x == 64:
		guyx = 466
	if global_position.x == 540:
		guyx = -20
	if global_position.x == -20:
		guyx = 540
	if global_position.y == 466:
		guyy = 64
	if global_position.y == 64:
		guyy = 466
	if global_position.y == 540:
		guyy = -20
	if global_position.y == -20:
		guyy = 540
	global_position = Vector2(guyx, guyy)
	guy_instance2.ismirror = true
	mirrorself = guy_instance2
	guy_instance2.mirrorself = self
	game_manager.add_child(guy_instance2)
	game_manager.enemyList.append(guy_instance2)
	alreadycloned = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea" && ismirror == true:
		die()
		mirrorself.die()
	else:
		if ismirror == true:
			game_manager._damage_centerpiece(1)
			die()
			mirrorself.die()
	pass # Replace with function body.
   	 
func _physics_process(delta):
	super._physics_process(delta)
	#$CollisionShape2D/mainSprite.flip_h = (velocity.x<0)
	#if velocity.length()<10 and not dead_man_walking:
		#$CollisionShape2D/mainSprite.play("idle")
func die():
	dead_man_walking = true
	game_manager.player.speed = 50
	#$CollisionShape2D/mainSprite.play("die")
	#await get_tree().create_timer(0.4).timeout
	game_manager.player.speed = 200
	super.die()
func nomirrors():
	ismirror = false
	$CollisionShape2D.disabled = true
func yesmirrors():
	ismirror = true
	$CollisionShape2D/Sprite2D.visible = false
