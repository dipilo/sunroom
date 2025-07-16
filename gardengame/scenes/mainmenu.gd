extends Control
var selected_lvl_path = ""
@export var levels = ["res://Levels/level1.tscn",
"res://Levels/level2.tscn",
"res://Levels/level3.tscn"]
func _ready():
	match GlobalScript.game_state:
		0:
			$"lvlselect/game status".text = "Select Level"
		1:
			$"lvlselect/game status".text = "this text should never appear. If you see this, something has gone wrong"
		2:
			$"lvlselect/game status".text = "You Win! Play Again?"
		3:
			$"lvlselect/game status".text = "You Lose! Play Again?"
		4:
			$"lvlselect/game status".text = "CONSUMED BY GUILT"


func _enter_lvl1() -> void:
	initate_level_brief("res://Levels/level1.tscn")
	


func _enter_lvl2() -> void:
	initate_level_brief("res://Levels/level2.tscn")


func _enter_lvl3() -> void:
	initate_level_brief("res://Levels/level3.tscn")

func initate_level_brief(lvl_path : String):
	selected_lvl_path = lvl_path
	$lvlselect.visible = false
	$levelBriefing.visible = true
	var enemies_for_tutorial = []
	match lvl_path:
		"res://Levels/level1.tscn":
			enemies_for_tutorial = ["gameshow", "squash", "circle", "sound"]
		"res://Levels/level2.tscn":
			enemies_for_tutorial = ["inverter", "speaker"]
		"res://Levels/level3.tscn":
			enemies_for_tutorial = ["grief"]
	for j in enemies_for_tutorial:
		var new = load("res://scenes/template_tutorial.tscn").instantiate()
		var image = load("res://textures/gameshow_textures/GameshowAnim1.png")
		var text = "-Gameshow Man- Correctly answer his questions, and he won't get mad!"
		match j:
			"gameshow":
				image = load("res://textures/gameshow_textures/GameshowAnim1.png")
				text = "-Gameshow Man- Correctly answer his questions, and he won't get mad!"
			"squash":
				image = load("res://textures/bunny_textures/BunnyAnim1.png")
				text = "-Bunny- Collide with it to destroy, and don't let it reach your bed!"
			"circle":
				image = load("res://textures/eyeball_textures/eyeball yall call.png")
				text = "-Eyeball- Run a circle around it to destroy! Don't let it reach your bed!"
			"sound":
				image = load("res://textures/item_textures/SoundWomanAnim1.png")
				text = "-Sound Lady- She won't appear if you stay quiet. Keep the noise down, or you can't stop her!"
			"inverter":
				image = load("res://textures/item_textures/hand1.png")
				text = "-Hand Of Fate- Once it spawns, your movement is inverted! Collide with it to destroy."
			"speaker":
				image = load("res://textures/item_textures/antenmna-4.png.png")
				text = "-Speaker- Spawns occasionally and creates sound. You can't stop it."
			"grief":
				image = load("res://textures/item_textures/spine is coming merge is here-1.png(1).png")
				text = "-GRIEF- Spawns rarely and chases YOU down for an instant death. Decays over time."
		new.get_node("TextureRect").texture = image
		new.get_node("Label").text = text
		$levelBriefing/GridContainer.add_child(new)


func _on_enter_level_button_down() -> void:
	GlobalScript.game_state = 1
	get_tree().change_scene_to_file("res://scenes/battlefield.tscn")


func _on_cancel_button_down() -> void:
	$lvlselect.visible = true
	$levelBriefing.visible = false
	for i in $levelBriefing/GridContainer.get_children():
		i.queue_free()
