extends Node2D

var radius = 100
var speed = 1
var angle = 0
var randomness = 5
var particle: CPUParticles2D

func _ready():
	particle = $CPUParticles2D
	particle.emitting = true

func _process(delta):
	angle += speed * delta

	var x = radius * cos(angle) + randf_range(-randomness, randomness)
	var y = radius * sin(angle) + randf_range(-randomness, randomness)

	particle.position = Vector2(x, y)
