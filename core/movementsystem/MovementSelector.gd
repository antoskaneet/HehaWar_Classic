extends Node

class_name MovementSelector

var movement = Movement.new()
var _unit
var _movement_area: Array

func init() -> void:
	EventBus.set_movement_area.connect(_on_movement_selected)
	EventBus.move.connect(_move_unit_to_tile)
	EventBus.clear_movement_area.connect(_clear_movement_area)
	
func _on_movement_selected(unit):
	PathFinder.set_seleted_unit(unit)
	movement.remove_movement_area(_movement_area)
	_movement_area = PathFinder.get_unit_area(unit.data.radius)
	movement.set_movement_area(_movement_area)
	_unit = unit
	
func _move_unit_to_tile(_grass):
	EventBus.clear_attack_area.emit()
	movement.move(_unit, _grass, _movement_area)

func _clear_movement_area():
	movement.remove_movement_area(_movement_area)
	_movement_area.clear()
