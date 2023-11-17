extends Resource

@export var max_health: int
@export var speed: int
@export var string: String

func _init(
	p_max_health = 100,
	p_speed = 10,
	p_string = "Guana"
	):
	max_health = p_max_health
	speed = p_speed
	string = p_string
