extends Area3D
@onready var ee_timer = $SkillTimer

var cooldown : float = 2.3
var skill_stage : int
var cast_time : float = 0.400

enum stage_step {
	MODE_FIRST,
	MODE_SECOND,
	MODE_THIRD,
	MODE_FOURTH
	};

#func _physics_process(delta):
#	prints("t: ",qu_timer.get_time_left())

func e_skill_effect(body:Node3D):
	body.get_parent_node_3d().from_composed_damage(35)

func get_cooldown():
	return (cooldown+cast_time)

func _ready():
	body_entered.connect(e_skill_effect)
	skill_stage = stage_step.MODE_FIRST
	ee_timer.timeout.connect(_on_timer_timeout)
	ee_timer.set_wait_time(10.0)
	ee_timer.set_one_shot(true)
	set_monitoring(false)

	
func _on_timer_timeout():
	match skill_stage:
		stage_step.MODE_SECOND:
			skill_stage = stage_step.MODE_THIRD
			set_visible(false)
			set_monitoring(false)
			ee_timer.start(cooldown)
		stage_step.MODE_THIRD:
			skill_stage = stage_step.MODE_FIRST
		_:
			print("TOTAL FAIL")

func execute():
	if skill_stage == stage_step.MODE_FIRST:
		skill_stage = stage_step.MODE_SECOND
		ee_timer.start(cast_time)
		print(" Execyte ")
		set_visible(true)
		set_monitoring(true)
