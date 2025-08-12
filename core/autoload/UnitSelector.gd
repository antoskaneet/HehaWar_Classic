extends Node

var current_unit: Node
var movement_selector = MovementSelector.new()
var attack_selector = AttackSelector.new()

func _ready():
	EventBus.unit_input_selected.connect(_on_movement_unit_selected)
	EventBus.grass_input_selected.connect(_on_movement_grass_selected)
	EventBus.unit_attacked_selected.connect(_on_unit_attacked_selected)
	movement_selector.init()
	attack_selector.init()
	
func _on_movement_unit_selected(_unit_input: Node):
	var unit = _unit_input.get_parent()
	EventBus.set_movement_area.emit(unit)
	EventBus.set_attack_area.emit(unit)
	
func _on_movement_grass_selected(_grass_input: Node):
	var grass = _grass_input.get_parent()
	EventBus.move.emit(grass)
	
func _on_unit_attacked_selected(unit):
	EventBus.attack.emit(unit)
