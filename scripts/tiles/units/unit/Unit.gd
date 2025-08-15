extends Node

@onready var unit = self

var data = UnitData.new()

func _ready():
	add_to_group("unit")
	#TeamManager.set_color(self)
	GridRegistry.registry(unit, unit.global_position)
