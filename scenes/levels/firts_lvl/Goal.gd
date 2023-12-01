extends MeshInstance3D

@onready var player = $"../Player"
signal win

func _physics_process(delta):
	if player == null:
		queue_free()
		return
	var dist = 	get_global_position().distance_to(player.get_global_position())
	if dist < 1.0:
		win.emit()
		queue_free()
