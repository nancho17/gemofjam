extends RigidBody3D

var proyectiles_pos = Vector3(0.0,0.0,0.0)
var proyectiles_init_v = Vector3(0,0,0)
var range :int  = 12


func get_range():
	return range

func execute():
	prints(self,"Go first skill test", get_global_position())
	set_freeze_enabled(true)
	set_position(proyectiles_pos)
	set_linear_velocity(proyectiles_init_v)
	var force_vector = Vector3(120,12,0)
	set_freeze_enabled(false)
	apply_central_force(force_vector)
