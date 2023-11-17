extends Node3D
@onready var qu_timer :Timer = $Qskill/QuTimer
@onready var qskill = $Qskill

var cooldown : float = 2.3
var skill_stage : int

enum stage_step {
	MODE_FIRST,
	MODE_SECOND,
	MODE_THIRD,
	MODE_FOURTH
	};

#func _physics_process(delta):
#	prints("t: ",qu_timer.get_time_left())

func _ready():
	skill_stage = stage_step.MODE_FIRST
	qu_timer.timeout.connect(_on_timer_timeout)
	qu_timer.set_wait_time(10.0)
	qu_timer.set_one_shot(true)
	qskill.set_monitoring(false)

	
func _on_timer_timeout():
	match skill_stage:
		stage_step.MODE_SECOND:
			skill_stage = stage_step.MODE_THIRD
			qskill.set_visible(false)
			qskill.set_monitoring(false)
			qu_timer.start(cooldown)
			print("end qskill")
		stage_step.MODE_THIRD:
			skill_stage = stage_step.MODE_FIRST
			print("cooled and ready")
		_:
			print("TOTAL FAIL")

func q_skill():
	if skill_stage == stage_step.MODE_FIRST:
		skill_stage = stage_step.MODE_SECOND
		qu_timer.start(0.300)
		print("qskill qskill")
		qskill.set_visible(true)
		qskill.set_monitoring(true)
