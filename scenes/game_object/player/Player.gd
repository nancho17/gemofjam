extends Node3D

@onready var qskill = $Character/Skills/Qskill

func _ready():
	$PlayerCam.set_current(true)
	qskill.body_entered.connect(q_skill_effect)

func q_skill_effect(body:Node3D):
	prints("A body: ", body.get_parent_node_3d().name)
	body.get_parent_node_3d().from_composed_damage(10)
	
