extends Area3D

@export var squad_unit_scene: PackedScene
var squad: Array[Node3D] = []

func _ready():
	for child_node in self.get_children():
		squad.append(child_node)
