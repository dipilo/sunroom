extends CharacterBody2D

@export var speed = 100

func get_input():
	var input_direction = Input.get_vector("direction_left", "direction_right", "direction_up", "direction_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
