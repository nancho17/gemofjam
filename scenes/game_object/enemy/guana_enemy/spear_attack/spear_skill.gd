extends RigidBody3D

@onready var skill_timer :Timer = $SkillTimer
@onready var character = $"../../.."

enum stage_step {
	MODE_FIRST,
	MODE_SECOND,
	MODE_THIRD,
	MODE_FOURTH
	};

const proyectiles_init_v = Vector3(0,0,0)
const impulse :int = 120
const cast_time : float = 0.900

var skill_stage : int
var cooldown : float = 1.0
var stat_range :int  = 12

var proyectiles_init_pos : Vector3
var transform_init : Transform3D 

var main_targert : Vector3 = Vector3(0,0,0) 

func get_range():
	return stat_range

func set_target(tar : Vector3):
	main_targert = tar
	
func _ready():
	body_entered.connect(skill_impact)
	set_lock_rotation_enabled(true)
	proyectiles_init_pos = get_position()
	transform_init = get_transform()
	skill_stage = stage_step.MODE_FIRST
	skill_timer.timeout.connect(_on_timer_timeout)
	skill_timer.set_wait_time(10.0)
	skill_timer.set_one_shot(true)
	skill_hold()
	set_contact_monitor(true)

func skill_hold():
	set_visible(false)
	set_freeze_enabled(true)
	set_position(proyectiles_init_pos)
	set_linear_velocity(proyectiles_init_v)

func rotate_char(obj_position : Vector3):
	if skill_stage == stage_step.MODE_FIRST:
		skill_hold()
		var p_origin = character.global_transform.origin
		var dir_to = (obj_position - p_origin)
		set_transform(transform_init)
		var angle_rot = -atan2(dir_to.z, dir_to.x)
		var angle_to = lerp_angle(character.rotation.y,angle_rot,0.78)
		character.rotation.y = angle_rot# angle_to
		transform_init = get_transform()
		proyectiles_init_pos = get_position()


func _on_timer_timeout():
	match skill_stage:
		stage_step.MODE_SECOND:
			skill_stage = stage_step.MODE_THIRD
			set_visible(false)
			skill_timer.start(cooldown)
		stage_step.MODE_THIRD:
			skill_hold()
			skill_stage = stage_step.MODE_FIRST
		_:
			prints(self,"SKILL TOTAL FAIL")

func execute(obj_pos : Vector3):
	if skill_stage == stage_step.MODE_FIRST:
		rotate_char(obj_pos)
		physic_execute(obj_pos)
		skill_stage = stage_step.MODE_SECOND
		skill_timer.start(cast_time)
		set_visible(true)



func physic_execute(obj_position : Vector3):
	set_freeze_enabled(true)
	set_position(proyectiles_init_pos)
	set_linear_velocity(proyectiles_init_v)

	var dir_vec = (obj_position - get_global_position()).normalized()

	var local_objective_node = to_local(obj_position)
	var is_new_dir_vec = local_objective_node #+ proyectiles_init_pos
	var an_angle:float = -atan(is_new_dir_vec.z/is_new_dir_vec.x)
	var relleno_transform = transform_init.rotated_local(Vector3(0.0,1.0,0.0).normalized(), an_angle)
	set_transform(relleno_transform)
	
	var force_vector = Vector3(dir_vec.x*impulse,12,dir_vec.z *impulse)
	apply_central_force(force_vector)
	set_freeze_enabled(false)
#	print(rotation.y)

func skill_impact(a_body : Node3D):
	skill_stage = stage_step.MODE_THIRD
	skill_timer.start(0.300)
	if a_body.get_parent_node_3d().is_in_group("playable"):
		a_body.get_parent_node_3d().from_composed_damage(10)

	prints("found",a_body.get_parent().name)
