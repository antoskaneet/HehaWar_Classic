extends Node

@onready var unit = self

var data = UnitData.new()

func _ready():
	add_to_group("unit")
	TeamManager.add_unit_to_team(self)
	GridRegistry.registry(unit, unit.global_position)
	InputManager.disable_input(unit.get_node("InputUnit"), "right_click_select")
