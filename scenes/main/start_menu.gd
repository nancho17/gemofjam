extends CanvasLayer

func _ready():
	$Panel/VBoxContainer/PlayButton.pressed.connect(play_pressed)
	$Panel/VBoxContainer/QuitButton.pressed.connect(quit_pressed)

func play_pressed():
	print("change scene")
	get_tree().change_scene_to_file("res://scenes/levels/firts_lvl/first_lvl.tscn")

func quit_pressed():
	get_tree().quit()
