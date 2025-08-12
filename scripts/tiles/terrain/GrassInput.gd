extends Node

func _ready() -> void:
	self.monitoring = false
	self.visible = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("click_grass")
		EventBus.grass_input_selected.emit(self)
