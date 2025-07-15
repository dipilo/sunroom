extends Node2D
@export var size = Vector2(520,520)
var i = 0
var noise_texture

func _ready():
	noise_texture = $Sprite2D.texture as NoiseTexture2D
	var noise = noise_texture.noise
	noise.seed = randf()*100

	noise_texture.noise = noise
func _process(delta: float) -> void:
	$Sprite2D.rotate(deg_to_rad(0.002/delta))
	
	
	
	
