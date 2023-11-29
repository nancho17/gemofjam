extends Area3D

@export var squad_unit_scene: PackedScene
@onready var squad_base = $SquadBase


var squad: Array[Node3D] = []
var enemy_agent:Node3D

func _ready():
	body_entered.connect(enemy_sight)
	for child_node in squad_base.get_children():
		squad.append(child_node)

func enemy_sight(body:Node3D):
	enemy_agent = body
	for child_node in squad:
		child_node.set_target(body)
