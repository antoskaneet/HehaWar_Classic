extends Area2D

signal unit_selected(data: UnitData)
var data: UnitData

func _ready():
	print("hex_loaded")
	data = get_parent().data
	MovementSystem.register_unit(self)

func _on_hex_selected(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("click")
		emit_signal("unit_selected", data)
