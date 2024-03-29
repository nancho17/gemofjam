extends Node3D

@export var end_scene: PackedScene
@onready var player = $Player
@onready var goal = $Goal

func _ready():
	player.died.connect(on_player_died)
	goal.win.connect(on_player_died)


func on_player_died():
	var end_screen_instance = end_scene.instantiate()
	add_child(end_screen_instance)
