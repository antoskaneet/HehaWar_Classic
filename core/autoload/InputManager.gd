extends Node

var enabled_input := {}

func _ready():
	EventBus.unit_input_right_click.connect(_unit_input)
	EventBus.unit_input_target_right_click.connect(_unit_input)
	
func is_enabled(unit_input, input_type) -> bool:
	return enabled_input.has(unit_input) and enabled_input[unit_input].has(input_type)
	
func enable_input(unit_input, input_type):
	if not enabled_input.has(unit_input):
		enabled_input[unit_input] = {}
	enabled_input[unit_input][input_type] = true

func disable_input(unit_input, input_type):
	if enabled_input.has(unit_input) and enabled_input[unit_input].has(input_type):
		enabled_input[unit_input].erase(input_type)
		if enabled_input[unit_input].size() == 0:
			enabled_input.erase(unit_input)
	
func _unit_input(unit_input, input_type):
	if not enabled_input.has(unit_input):
		return
	if not enabled_input[unit_input].has(input_type):
		return
	match input_type:
		"right_click_select":
			EventBus.unit_input_selected.emit(unit_input)
			print("2")
		"right_click_target":
			EventBus.unit_input_attacked_selected.emit(unit_input)
			print("гаварю атакуй")
		_:
			pass
