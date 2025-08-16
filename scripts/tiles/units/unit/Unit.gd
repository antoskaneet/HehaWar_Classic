extends Node

@onready var unit = self

var data = UnitData.new()

func _ready():
	add_to_group("unit")
	unit.get_node("InputUnit").monitoring = false
	#TeamManager.set_color(self)
	GridRegistry.registry(unit, unit.global_position)
	InputManager.enable_input(get_node("InputUnit"), "right_click_select")
