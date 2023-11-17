extends Node3D
@export var stats: Resource
@onready var character = $GuanaChar
@onready var life_progress_bar = $Bars/LifeViewport/LifeProgressBar
@onready var label = $Bars/LifeViewport/Label


var current_health : int

func _ready():

	if stats:
		current_health = stats.max_health
		life_progress_bar.set_max(stats.max_health)
		life_progress_bar.set_value(stats.max_health)
		print(current_health)
	else:
		queue_free()

func _process(delta):
	pass

func from_composed_damage(received_damage : int):
	decrease_health(received_damage)

func decrease_health(health_delta : int):
	current_health = max(current_health - health_delta,0)
	life_progress_bar.set_value(current_health)
	var eme = "H %s" % current_health
	label.set_text(eme)
	if current_health == 0:
		prints("this is dead")
		current_health = stats.max_health

