extends Area2D

func _on_hex_selected(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("выбераю")
		EventBus.unit_input_right_click.emit(self, "right_click_select")

func _on_unit_attacked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("атакую")
		EventBus.unit_input_target_right_click.emit(self, "right_click_target")
