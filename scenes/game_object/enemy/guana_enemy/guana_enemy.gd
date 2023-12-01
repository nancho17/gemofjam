extends Node3D
@export var stats: Resource
@onready var character = $GuanaChar
@onready var life_progress_bar = $Bars/LifeViewport/LifeProgressBar
@onready var label = $Bars/LifeViewport/Label
@onready var char_controller = $CharController

var current_health : int

func get_controller():
		return char_controller

func set_target(traget_n :Node3D ):
		char_controller.set_objective(traget_n)

func _ready():
	if stats:
		current_health = stats.max_health
		life_progress_bar.set_max(stats.max_health)
		life_progress_bar.set_value(stats.max_health)
		var eme = "H%s" % current_health
		label.set_text(eme)
	else:
		queue_free()

func from_composed_damage(received_damage : int):
	decrease_health(received_damage)

func decrease_health(health_delta : int):
	current_health = max(current_health - health_delta,0)
	prints(self,current_health )
	life_progress_bar.set_value(current_health)
	var eme = "H%s" % current_health
	label.set_text(eme)
	if current_health == 0:
		prints("this is dead")
		queue_free()
		


