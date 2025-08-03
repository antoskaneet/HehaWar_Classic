extends Node

@onready var inputunit = $InputUnit
@onready var unit = self

signal unit_selected(unit: Node)
var data = UnitData.new()

func _ready():
	print("hex_loaded")
	add_to_group("unit")
	GridRegistry.registry(unit, unit.position)
	inputunit.unit_selected.connect(_on_hex_unit_selected)
	UnitSelector.register_unit(self)
	data.radius = 1

func _on_hex_unit_selected():
	emit_signal("unit_selected", unit)
