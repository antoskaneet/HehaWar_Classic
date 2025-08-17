extends Node

var teams := {}

func add_unit_to_team(_unit: Node):
	var color_str = _unit.data.color
	if not teams.has(color_str):
		teams[color_str] = {}
	teams[color_str][_unit] = true

func get_team(color_str: String) -> Array:
	if not teams.has(color_str):
		return []
	return teams[color_str].keys()
