extends CanvasLayer

@onready var q_clock = $Control/MarginContainer/GridContainer/QPanel/Clock
@onready var w_clock = $Control/MarginContainer/GridContainer/WPanel/Clock
@onready var e_clock = $Control/MarginContainer/GridContainer/EPanel/Clock
@onready var r_clock = $Control/MarginContainer/GridContainer/RPanel/Clock

func ui_q_skill():
	q_clock.skill_executed_ui()

func ui_w_skill():
	w_clock.skill_executed_ui()

func ui_e_skill():
	e_clock.skill_executed_ui()

func ui_r_skill():
	r_clock.skill_executed_ui()
	

