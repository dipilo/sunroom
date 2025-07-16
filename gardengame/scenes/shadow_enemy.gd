extends "res://scenes/enemy.gd"

var mirrorself
var ismirror = false

func _init():
	movement_chance = 1

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
