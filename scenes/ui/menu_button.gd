extends Button

func _ready():
	pressed.connect(on_pressed)


func on_pressed():
	print(self.text)
