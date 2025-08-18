extends Node

@onready var team_keys = TeamManager.teams.keys()
var current_team_index = -1

func spend_unit_action(_unit: Node, cost: int):
	_unit.data.action_points = max(_unit.data.action_points - cost, 0)
	if _unit.data.action_points == 0:
		InputManager.disable_input(_unit.get_node("InputUnit"), "right_click_select")
		
		# var no_activ_color = UnitColorManager.darken_color_str(_unit.data.color, 0.6)
		var darken_color_str = UnitColorManager.darken_color(_unit.data.color)
		UnitColorManager.set_color(_unit, darken_color_str)

func next_team():
	if TeamManager.teams.is_empty():
		return

	# если первый раз, создаём список команд
	if team_keys.is_empty():
		team_keys = TeamManager.teams.keys()

	# выключаем прошлую команду
	if current_team_index >= 0:
		var prev_color = team_keys[current_team_index]
		for unit in TeamManager.get_team(prev_color):
			if is_instance_valid(unit):
				InputManager.disable_input(unit.get_node("InputUnit"), "right_click_select")
				UnitColorManager.set_color(unit, unit.data.color)
				
				
	# переключаем индекс по кругу
	current_team_index = (current_team_index + 1) % team_keys.size()

	# включаем новую команду
	var new_color = team_keys[current_team_index]
	for unit in TeamManager.get_team(new_color):
		if is_instance_valid(unit):
			InputManager.enable_input(unit.get_node("InputUnit"), "right_click_select")
			UnitColorManager.set_color(unit, unit.data.color)
			unit.data.action_points = unit.data.max_action_points
			unit.data.radius = unit.data.max_action_points

	print("Ход команды:", new_color)
