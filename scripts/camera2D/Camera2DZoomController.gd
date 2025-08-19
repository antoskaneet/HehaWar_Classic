extends Node

@onready var camera2d := get_parent().get_node("Camera2D")
@onready var camera2d_input := get_parent().get_node("Camera2DInput")

var target_zoom: Vector2

func _ready() -> void:
	target_zoom = camera2d.zoom

func _process(delta: float) -> void:
	zoom(delta)

func zoom(delta):
	if Input.is_action_just_pressed("scroll_up"):
		target_zoom *= Vector2(1.1, 1.1)
	if Input.is_action_just_pressed("scroll_down"):
		target_zoom *= Vector2(0.9, 0.9)
	camera2d.zoom = camera2d.zoom.slerp(target_zoom, 10 * delta)
