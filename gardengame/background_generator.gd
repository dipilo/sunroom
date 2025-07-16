extends Node2D
@export var size = Vector2(520,520)
@export var color = Color(0,0,0)
var i = 0
var noise_texture

func _ready():
	
	

	noise_texture = $Sprite2D.texture as NoiseTexture2D
	var gradient = noise_texture.color_ramp 
	gradient.add_point(0.0, Color.BLACK)
	gradient.add_point(1.0, color)
	noise_texture.color_ramp = gradient
	var noise = noise_texture.noise
	noise.seed = randf()*100

	noise_texture.noise = noise
func _process(delta: float) -> void:
	$Sprite2D.rotate(deg_to_rad(0.002/delta))
	
	
	
	
