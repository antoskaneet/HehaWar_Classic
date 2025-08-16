extends Node

class_name AttackSelector
var attack_area: Array
var attack = Attack.new()
var _unit_start

func init():
	EventBus.set_attack_area.connect(_set_attack_area)
	EventBus.attack.connect(_attack)
	EventBus.clear_attack_area.connect(_clear_attack_area)

func remove_units_by_color(units: Array, color_to_remove: String) -> Array:
	var new_units := []
	for u in units.duplicate():
		if u.data.color != color_to_remove:
			new_units.append(u)
	return new_units

func _set_attack_area(_unit):
	print("готволю зону для атаки")
	attack.remove_attack_area(attack_area)
	attack_area = PathFinder.get_units_in_range(1)
	attack_area = remove_units_by_color(attack_area, _unit.data.color)
	print(attack_area)
	attack.set_attack_area(attack_area)
	_unit_start = _unit

func _attack(_unit):
	attack.attack(_unit_start, _unit)
	self._clear_attack_area()
	
func _clear_attack_area():
	attack.remove_attack_area(attack_area)
	attack_area.clear()
