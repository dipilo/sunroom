extends CharacterBody2D
var game_manager
@export var speed = 200
var has_paper = false
var negetive = 1
func _ready():
	await get_tree().process_frame
	GlobalScript.gamemanger.player = self
	game_manager = GlobalScript.gamemanger 
	print("player set")
func get_input():
	var input_direction = Input.get_vector("direction_left", "direction_right", "direction_up", "direction_down")
	velocity = input_direction * speed* negetive
	if not game_manager == null:
		game_manager.noise += 0.00001 * input_direction.length()

func _physics_process(delta):
	get_input()
	move_and_slide()
	$CollisionShape2D/AnimatedSprite2D.flip_h = (velocity.x>0)
	if velocity.length()<10:
		$CollisionShape2D/AnimatedSprite2D.play("idle")
	elif abs(velocity.y)>abs(velocity.x):
		$CollisionShape2D/AnimatedSprite2D.play("walk_front")
	else:
		$CollisionShape2D/AnimatedSprite2D.play("walk_side")
func _paper(new: bool):
	has_paper = new
	#$paper.visible = new
