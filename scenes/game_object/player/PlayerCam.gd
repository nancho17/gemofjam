extends Camera3D

var camera_zoom : int = 0
var original_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position
	set_process_priority(10)

func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		camera_zoom-=1
		do_zoom()
	if Input.is_action_just_pressed("zoom_out"):
		camera_zoom+=1
		do_zoom()

func do_zoom():
	camera_zoom = clamp(camera_zoom,0,15)
	position= original_pos * (1+(camera_zoom*0.10))
	prints("Cam zoom val:",camera_zoom,position)
