extends Node2D

var enemyList = []
var board
func _ready() -> void:
	GlobalScript.gamemanger = self
	await get_tree().process_frame
	board = GlobalScript.board
func _game_loop() -> void:
	for enemy in enemyList:
		enemy._update()
