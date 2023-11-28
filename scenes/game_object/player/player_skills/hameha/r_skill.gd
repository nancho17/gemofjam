extends Area3D
@onready var skill_timer :Timer = $SkillTimer

var cooldown : float = 45.0
var cast_time : float = 1.5
var skill_stage : int
var damage_send : int = 100

enum stage_step {
	MODE_FIRST,
	MODE_SECOND,
	MODE_THIRD,
	MODE_FOURTH
	};

#func _physics_process(delta):
#	prints("t: ",skill_timer.get_time_left())1

func q_skill_effect(body:Node3D):
	prints("A body: ", body.get_parent_node_3d().name)
	body.get_parent_node_3d().from_composed_damage(damage_send)

func get_cooldown():
	return (cooldown+cast_time)

func _ready():
	body_entered.connect(q_skill_effect)
	skill_stage = stage_step.MODE_FIRST
	skill_timer.timeout.connect(_on_timer_timeout)
	skill_timer.set_wait_time(10.0)
	skill_timer.set_one_shot(true)
	set_monitoring(false)

	
func _on_timer_timeout():
	match skill_stage:
		stage_step.MODE_SECOND:
			skill_stage = stage_step.MODE_THIRD
			set_visible(false)
			set_monitoring(false)
			skill_timer.start(cooldown)
			print("end")
		stage_step.MODE_THIRD:
			skill_stage = stage_step.MODE_FIRST
			print("cooled and ready")
		_:
			print("SKILL TOTAL FAIL")

func execute():
	if skill_stage == stage_step.MODE_FIRST:
		skill_stage = stage_step.MODE_SECOND
		skill_timer.start(cast_time)
		set_visible(true)
		set_monitoring(true)
