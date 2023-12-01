extends Area3D

@export var squad_unit_scene: PackedScene
@onready var squad_base = $SquadBase

@onready var action_timer = $Timer

var squad: Array[Node3D] = []
var enemy_agent:Node3D
var action_stage : int

enum stage_step {
	ACTION_FIRST,
	ACTION_SECOND,
	ACTION_THIRD,
	ACTION_FOURTH
	};

func _ready():
	body_entered.connect(enemy_sight)
	for child_node in squad_base.get_children():
		squad.append(child_node)
	action_timer.timeout.connect(_on_timer_timeout)
	action_timer.set_wait_time(0.2)
	action_timer.start()
	prints("size" , squad.size()) 


func _on_timer_timeout():
	match action_stage:
		stage_step.ACTION_FIRST:
			action_stage = stage_step.ACTION_SECOND
			action_1()
#			prints(self,"ACTION_FIRST")
		stage_step.ACTION_SECOND:
			action_stage = stage_step.ACTION_THIRD
			action_1()
#			prints(self,"ACTION_SECOND")
		stage_step.ACTION_THIRD:
			action_stage = stage_step.ACTION_FIRST
			action_1()
#			prints(self,"ACTION_THIRD")
		_:
			prints(self,"ACTION TOTAL FAIL")

func action_1():
	for squad_unit in squad_base.get_children():
		if squad_unit.get_controller().execute_skill():
			return

func enemy_sight(body:Node3D):
	enemy_agent = body
	for child_node in squad_base.get_children():
		child_node.get_controller().set_objective(body)
		
	#func set_target(traget_n :Node3D ):
#		char_controller.set_objective(traget_n)k

