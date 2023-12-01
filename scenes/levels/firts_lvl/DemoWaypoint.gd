extends Control


# Some margin to keep the marker away from the screen's corners.
const MARGIN = 8

@onready var camera = get_viewport().get_camera_3d()
@onready var parent = get_parent()
@onready var label = $Label
@onready var marker = $TextureRect

# The waypoint's text.
@export var text = "Waypoint":
	set(value):
		text = value
		# The label's text can only be set once the node is ready.
		if is_inside_tree():
			label.text = value

# If `true`, the waypoint sticks to the viewport's edges when moving off-screen.
@export var sticky = true


func _ready() -> void:
	self.text = text

	if not parent is Node3D:
		push_error("The waypoint's parent node must inherit from Node3D.")


func _process(_delta):
	if camera == null:
		camera = get_viewport().get_camera_3d()
		return

	if not camera.current:
		# If the camera we have isn't the current one, get the current camera.
		camera = get_viewport().get_camera_3d()
		pass

	var parent_position = parent.global_transform.origin
	var camera_transform = camera.global_transform
	var camera_position = camera_transform.origin

	# We would use "camera.is_position_behind(parent_position)", except
	# that it also accounts for the near clip plane, which we don't want.
	#var is_behind = camera_transform.basis.z.dot(parent_position - camera_position) > 0

	# Fade the waypoint when the camera gets close.
	var distance = camera_position.distance_to(parent_position)
	modulate.a = clamp(remap(distance, 0, 2, 0, 1), 0, 1 )
	

	var ob_pos_cam = parent_position * camera_transform
	var btest = camera_position * camera_transform
	var test_val = camera_transform * ob_pos_cam
	
	var viewport_base_size = get_viewport().size

	var unprojected_position
	if not camera.is_position_behind(parent_position):
		unprojected_position = camera.unproject_position(parent_position)
	else:
		# Need to be fixed using get_projection_for_view as tranformed coordenttaes from viewport
		unprojected_position = Vector2(( (ob_pos_cam.x * 0.5) +0.5) * viewport_base_size.x ,( (-ob_pos_cam.y * 0.5) + 0.5) * viewport_base_size.y)  

	if not sticky:
		position = unprojected_position
		return

	position = Vector2(
			clamp(unprojected_position.x, MARGIN, viewport_base_size.x - MARGIN),
			clamp(unprojected_position.y, MARGIN, viewport_base_size.y - MARGIN)
	)
	label.visible = true
	rotation = 0


	# Used to display a diagonal arrow when the waypoint is displayed in
	# one of the screen corners.
	var overflow = 0

	if position.x <= MARGIN:
		# Left overflow.
		overflow = -TAU / 8.0
		label.visible = false
		rotation = TAU / 4.0
	elif position.x >= viewport_base_size.x - MARGIN:
		# Right overflow.
		overflow = TAU / 8.0
		label.visible = false
		rotation = TAU * 3.0 / 4.0

	if position.y <= MARGIN:
		# Top overflow.
		label.visible = false
		rotation = TAU / 2.0 + overflow
	elif position.y >= viewport_base_size.y - MARGIN:
		# Bottom overflow.
		label.visible = false
		rotation = -overflow


static func angle_diff(from, to):
	var diff = fmod(to - from, TAU)
	return fmod(2.0 * diff, TAU) - diff
