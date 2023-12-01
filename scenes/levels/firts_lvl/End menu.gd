extends CanvasLayer
@onready var gomenu = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Gomenu

func _ready():
	get_tree().paused = true
	gomenu.pressed.connect(on_continue_button_pressed)

func on_continue_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/start_menu.tscn")
