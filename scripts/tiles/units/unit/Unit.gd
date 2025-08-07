extends Node

@onready var inputunit = $InputUnit
@onready var unit = self

var data = UnitData.new()

signal unit_selected(unit: Node)

func _ready():
	add_to_group("unit")
	GridRegistry.registry(unit, unit.global_position)
	UnitSelector.register_unit(self)
	inputunit.unit_selected.connect(_on_hex_unit_selected)
	
	data.radius = 3

func _on_hex_unit_selected():
	emit_signal("unit_selected", unit)
