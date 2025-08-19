extends Node

var zoom_direction: float

func get_move_direction() -> Vector2:
	return Input.get_vector("camera_a", "camera_d", "camera_w", "camera_s")
