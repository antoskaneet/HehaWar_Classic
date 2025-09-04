extends RefCounted

class_name Attack
	
func set_attack_area(attack_area: Array):
	for _unit in attack_area:
		_unit.get_node("UnitState").activate()
	
func remove_attack_area(attack_area: Array):
	for _unit in attack_area:
		_unit.get_node("UnitState").un_activate()

func get_max_damage(hp: int) -> int:
	return min(hp, 7)

func calculate_damage(start_unit) -> int:
	var hp = start_unit.data.hp
	var max_damage = get_max_damage(hp)
	return randi_range(1, max_damage)

func attack(start_unit, _unit):
	EventBus.clear_movement_area.emit()
	TurnManager.spend_unit_action(
		start_unit,
		start_unit.data.max_action_points
		)

	var tween_node = _unit.get_parent().get_node("AttackTween")
	tween_node.attack_tween(_unit.get_parent(), start_unit.get_parent())

	tween_node.tween.finished.connect(func():
		var dmg = calculate_damage(start_unit)
		_unit.get_parent().get_node("UnitHP").take_damage.rpc(dmg))
