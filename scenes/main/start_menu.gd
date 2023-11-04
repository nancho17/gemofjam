extends CanvasLayer

func _ready():
	$Panel/VBoxContainer/PlayButton.pressed.connect(play_pressed)
	$Panel/VBoxContainer/QuitButton.pressed.connect(quit_pressed)

func play_pressed():
	print("change scene")


func quit_pressed():
	get_tree().quit()
