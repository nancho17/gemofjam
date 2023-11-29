extends Node3D
@export var stats: Resource

@onready var life_progress_bar = $LifeBar/SubViewport/Container/TextureProgressBar
@onready var qskill = $Character/Skills/Qskill

var current_health : int

func _ready():
	$PlayerCam.set_current(true)
	if stats:
		current_health = stats.max_health
		life_progress_bar.set_max(stats.max_health)
		life_progress_bar.set_value(stats.max_health)
		var eme = "H%s" % current_health
		print(eme)

	else:
		print("there is a problem")
		


func from_composed_damage(received_damage : int):
	decrease_health(received_damage)

func decrease_health(health_delta : int):
	current_health = max(current_health - health_delta,0)
	prints(self,current_health )
	life_progress_bar.set_value(current_health)
	var eme = "H%s" % current_health

	if current_health == 0:
		prints("this is dead")

