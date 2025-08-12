extends Node

class_name AttackSelector
var attack_area: Array
var attack = Attack.new()
var _unit_start

func init():
	EventBus.set_attack_area.connect(_set_attack_area)
	EventBus.attack.connect(_attack)
	EventBus.clear_attack_area.connect(_clear_attack_area)
	
func _set_attack_area(_unit):
	attack.remove_attack_area(attack_area)
	attack_area = PathFinder.get_units_in_range(1)
	attack.set_attack_area(attack_area)
	_unit_start = _unit

func _attack(_unit):
	attack.attack(_unit, _unit_start)
	self._clear_attack_area()
	
func _clear_attack_area():
	attack.remove_attack_area(attack_area)
	attack_area.clear()
