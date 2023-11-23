extends TextureRect

@export var skill : Area3D
@onready var skill_clock = $"."

var clock_res
var skill_time : float
var skill_clock_material : Material 
var skill_timeout : float

func _ready():
	skill_clock_material = skill_clock.get_material()
	
func _physics_process(delta):
	ui_time(delta)

func skill_executed_ui():
	if !skill_clock.is_visible():
		skill_timeout = skill.get_cooldown()
		skill_time = 0.0
		skill_clock.set_visible(true)

func ui_time(delta_time:float):
	if skill_clock.is_visible() and skill_clock_material!= null:
		skill_time += delta_time
		var angle = skill_time/skill_timeout
		angle = minf(angle , 1.0)
		skill_clock_material.set_shader_parameter("indicator_angle", angle)
		if angle == 1.0:
			skill_clock.set_visible(false)
			skill_time = 0.0
	
