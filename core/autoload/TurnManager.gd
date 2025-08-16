extends Node
	
func spend_unit_action(_unit: Node, cost: int):
	_unit.data.action_points = max(_unit.data.action_points - cost, 0)
	if _unit.data.action_points == 0:
		InputManager.disable_input(_unit.get_node("InputUnit"), "right_click_select")
