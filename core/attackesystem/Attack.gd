extends RefCounted

class_name Attack
	
func set_attack_area(attack_area: Array):
	for _unit in attack_area:
		_unit.get_node("UnitState").activate()
	
func remove_attack_area(attack_area: Array):
	for _unit in attack_area:
		_unit.get_node("UnitState").un_activate()

func get_max_damage(hp: int) -> int:
	if hp >= 7:
		return 7
	else:
		return hp

func calculate_damage(attacker) -> int:
	var hp = attacker.get_parent().data.hp
	var max_damage = get_max_damage(hp)
	return randi_range(1, max_damage)

func attack(attacker, target):
	EventBus.clear_movement_area.emit()

	var tween_node = attacker.get_parent().get_node("AttackTween")
	tween_node.attack_tween(attacker.get_parent(), target.get_parent())

	tween_node.tween.finished.connect(func():
		var dmg = calculate_damage(attacker)
		target.get_node("UnitHP").take_damage(dmg))
