extends Node

@export var speed: float = 1400.0
@onready var camera2d_input = get_parent().get_node("Camera2DInput")
@onready var camera2d = get_parent().get_node("Camera2D")

var isDragging := false
var dragStartMousePos := Vector2.ZERO
var dragStartCameraPos := Vector2.ZERO

func _process(delta: float) -> void:
	ClickAndDrag()
	var dir = camera2d_input.get_move_direction()
	if dir != Vector2.ZERO:
		get_parent().position += dir * speed * delta * (1/camera2d.zoom.x)
	
func ClickAndDrag():

	var mouse_pos = camera2d.get_global_mouse_position()
	var mouse_tile = Vector2i(mouse_pos.x, mouse_pos.y)

	var unit_under_mouse = GridRegistry.get_hex_position(mouse_tile, "unit")
	
	var current_color = null
	if TurnManager.team_keys.size() > 0 and TurnManager.current_team_index >= 0:
		current_color = TurnManager.team_keys[TurnManager.current_team_index]

	if not unit_under_mouse or (current_color and unit_under_mouse.data.color != current_color):
		if not isDragging and Input.is_action_pressed("camera_pan"):
			dragStartMousePos = get_viewport().get_mouse_position()
			dragStartCameraPos = camera2d.position
			isDragging = true

		if isDragging and not Input.is_action_pressed("camera_pan"):
			isDragging = false

		if isDragging:
			var moveVector = get_viewport().get_mouse_position() - dragStartMousePos
			camera2d.position = dragStartCameraPos - moveVector * (1 / camera2d.zoom.x)
	else:
		isDragging = false
