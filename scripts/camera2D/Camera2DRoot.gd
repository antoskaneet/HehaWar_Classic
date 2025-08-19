extends Node

@onready var camera_2d_input = get_node("Camera2DInput")
var speed = 100

func _process(delta: float) -> void:
	var move_direction = camera_2d_input.get_move_direction()
	self.position += move_direction * speed * delta
