@tool
extends EditorScript

var tool_set_instances : int = 20
var max_distance : float = 0.3

func _run():
	print("Wata!")

	var multigrass = get_scene()
#	var node = Node3D.new()
#	add_child(node) # Parent could be any node in the scene
#	# The line below is required to make the node visible in the Scene tree dock
#	# and persist changes made by the tool script to the saved scene file.
#	node.set_owner(get_tree().edited_scene_root)
	multigrass.multimesh.instance_count = 0
	multigrass.multimesh.set_transform_format(MultiMesh.TRANSFORM_3D)
	multigrass.multimesh.instance_count = tool_set_instances
	for i in range(tool_set_instances):
		var z_m = - 500 + ( i * 50)
		var instance_position = Transform3D()
		instance_position = instance_position.translated(Vector3(0.0, 0.0,z_m))
		prints("tebnemos:", i, instance_position)
		multigrass.multimesh.set_instance_transform(i, instance_position)

	multigrass.multimesh.visible_instance_count = tool_set_instances
