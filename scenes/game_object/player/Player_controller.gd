extends Node

# Exports
@onready var player_main = $".."
@onready var character = $"../Character"
@onready var character_skills = $"../Character/Skills"

var camera_one : Camera3D
var default_3d_map_rid : RID

var movement_speed: float = 4.0

# Command vars
var current_path_index: int = 0
var current_path_point: Vector3
var current_path: PackedVector3Array
var process_movement:bool = false
var path_point_margin: float = 1
var movement_delta: float
var target_pos : Vector3
const delta_pos : float = 0.1

var q_test = 0
var w_test = 0
var e_test = 0
var r_test = 0


func _ready():
	camera_one  = player_main.get_node("PlayerCam")
	call_deferred("custom_setup")

func custom_setup():
	default_3d_map_rid = player_main.get_world_3d().get_navigation_map()

func _process(_delta: float):
	var m_pos : Vector2 = get_viewport().get_mouse_position()
	
	if Input.is_action_pressed("pointer_command"):
		move_to_pointer(m_pos)

	if Input.is_action_just_pressed("q_skill"):
		process_movement = false
		q_test += 1 
		character_skills.q_skill()

	if Input.is_action_just_pressed("w_skill"):
		process_movement = false
		w_test += 1 
		prints("doblebe",w_test)

	if Input.is_action_just_pressed("e_skill"):
		e_test += 1 
		prints("e",e_test)

	if Input.is_action_just_pressed("r_skill"):
		r_test += 1 
		prints("erre",r_test)

func _physics_process(delta):
	movement_process(delta)

func set_movement_target(target_position: Vector3):
	var start_position: Vector3 = player_main.global_transform.origin
	current_path = NavigationServer3D.map_get_path(
		default_3d_map_rid,
		start_position,
		target_position,
		true
	)
	if not current_path.is_empty():
		current_path_index = 0
		current_path_point = current_path[0]
	process_movement = true

func movement_process(delta):
	if not process_movement:
		return


#	print("dist:" ,p_origin.distance_to(current_path_point))
	var p_origin = player_main.global_transform.origin
	movement_delta = movement_speed * delta

	if p_origin.distance_to(target_pos) < 2 or current_path.is_empty():
#		print("dist:" ,p_origin.distance_to(current_path_point))
		var n_direction: Vector3 = (target_pos - p_origin).normalized()
		character.rotation.y = lerp_angle(character.rotation.y,-atan2(n_direction.z, n_direction.x),0.1)
		player_main.global_transform.origin = p_origin.move_toward(target_pos, movement_delta)
		if p_origin==target_pos:
			process_movement = false
			print("done origin",p_origin,"target pos",target_pos)
	else:
		if p_origin.distance_to(current_path_point) <= path_point_margin:
			current_path_index += 1
			if current_path_index >= current_path.size():
				current_path = []
				current_path_index = 0
				current_path_point = p_origin
				return
			current_path_point = current_path[current_path_index]
		var n_new_velocity: Vector3 = (current_path_point - p_origin).normalized()
		character.rotation.y = lerp_angle(character.rotation.y,-atan2(n_new_velocity.z, n_new_velocity.x),0.1)
		var new_velocity: Vector3 = n_new_velocity * movement_delta
		player_main.global_transform.origin = p_origin.move_toward(current_path_point+new_velocity, movement_delta)

func move_to_pointer(m_pos: Vector2):
	var result :Dictionary = raycast_from_mouse(0b100111,m_pos)
	if !result.is_empty():
		move_to(result.position)
	else:
		print("ta jodido")
#Pointer select
func raycast_from_mouse (collision_mask_var , m_pos):
	var ray_start : Vector3 = camera_one.project_ray_origin(m_pos)
	var rey_end : Vector3 = ray_start + camera_one.project_ray_normal(m_pos) * 1000
	var space_state = player_main.get_world_3d().direct_space_state
	var prqp := PhysicsRayQueryParameters3D.new()
	prqp.from = ray_start
	prqp.to = rey_end
	prqp.collision_mask = collision_mask_var
	prqp.exclude = []
	return space_state.intersect_ray(prqp)

func move_to(recived_target_pos):
	#change_state("walking")
	#prints("recived_target_pos",recived_target_pos, "closest_pos" ,closest_pos)
	var a_map : RID = NavigationServer3D.get_maps()[0]
	#var a_map : RID = get_world_3d().get_navigation_map()
#	prints("get_maps",NavigationServer3D.get_maps(),"cell height", NavigationServer3D.map_get_cell_height(a_map))
#	prints("recived_target_pos",recived_target_pos)
#	prints("closest_pos", NavigationServer3D.map_get_closest_point(a_map, recived_target_pos) )
	
	var closest_pos = NavigationServer3D.map_get_closest_point(a_map, recived_target_pos)
	target_pos = closest_pos
	set_movement_target(closest_pos)
