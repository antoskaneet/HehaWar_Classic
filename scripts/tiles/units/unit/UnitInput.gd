extends Area2D

signal unit_selected()
signal unit_attacked()

func _on_hex_selected(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("click")
		emit_signal("unit_selected")

func enable_attacked_event():
	connect("input_event", Callable(self, "_on_unit_attacked"), CONNECT_DEFERRED)

func disable_attacked_event():
	if is_connected("input_event", Callable(self, "_on_unit_attacked")):
		disconnect("input_event", Callable(self, "_on_unit_attacked"))

func _on_unit_attacked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("test_clickus")
		emit_signal()
