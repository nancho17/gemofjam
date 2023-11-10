@tool
extends EditorScript

var tool_set_instances : int = 3100
var max_distance : float = 0.3

func _run():
	print("Oc oc oc oc !")

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
		# Get pixel value in random position
		
		var pos_angle :float = randf()* TAU
		var module :float = max_distance * (randf() * 0.8 + 0.2 * randf())
		var x:float =cos(pos_angle) * module
		var z:float =sin(pos_angle) * module
		var angle:float = randf() * TAU
		prints("tebnemos:",i,angle )
		
		# From the center of the texture
		var x_m:float = x
		var z_m:float = z

		var instance_position = Transform3D()
		instance_position = instance_position.scaled(Vector3(0.010,0.010,0.010))
		instance_position = instance_position.rotated_local(Vector3(0,1,0), angle)
		instance_position = instance_position.translated(Vector3(x_m, 0.0, z_m))
		

		multigrass.multimesh.set_instance_transform(i, instance_position)

	multigrass.multimesh.visible_instance_count = tool_set_instances
