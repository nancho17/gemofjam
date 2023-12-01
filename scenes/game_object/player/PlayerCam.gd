extends Camera3D

var camera_zoom : int = 0
var original_pos

func _ready():
	camera_zoom = 5
	original_pos = position
	position= original_pos * (1+(camera_zoom*0.10))
	set_process_priority(10)

func _process(_delta):
	# Where is (0, 100) relative to the player?
	var test_val = get_transform() * Vector3(0,0,10) #Vector3(0.996,2.04,1.031)
	var atest = test_val * get_transform()
	var apos = get_position()
	#prints("t:",atest,"pos:",apos,"parent:",get_parent().get_position() )
	if Input.is_action_just_pressed("zoom_in"):
		camera_zoom-=1
		do_zoom()
	if Input.is_action_just_pressed("zoom_out"):
		camera_zoom+=1
		do_zoom()

func do_zoom():
	camera_zoom = clamp(camera_zoom,0,15)
	position= original_pos * (1+(camera_zoom*0.10))
#	transform.origin = original_pos.basis.z * (1+(camera_zoom*0.10)) 
#	prints("Cam zoom val:",camera_zoom,position)
