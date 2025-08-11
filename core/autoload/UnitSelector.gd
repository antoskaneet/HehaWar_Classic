extends Node

var movement = Movement.new()
var attack = Attack.new()
var movement_area: Array
var attack_area: Array
var current_unit: Node

func register_unit(unit: Node):
	unit.unit_selected.connect(_on_unit_selected)
	
func register_grass(grass: Node):
	grass.grass_selected.connect(_on_hex_grass_selected)

func _on_unit_selected(unit: Node):
	print("Выбран юнит:", unit)
	PathFinder.set_seleted_unit(unit)
	attack.remove_attack_area()
	movement.remove_movement_area(movement_area)
	movement_area = PathFinder.get_movement_area()
	attack_area = PathFinder.get_attack_area()
	movement.set_movement_area(movement_area)
	current_unit = unit
	
func _on_hex_grass_selected(grass: Node):
	movement.move(current_unit, grass, movement_area)
	
func _on_unit_attacked():
	
