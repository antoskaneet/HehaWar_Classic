extends Node

@onready var data: RefCounted = get_parent().data
@onready var hp_label: Label = get_parent().get_node("LabelHP")

@rpc("any_peer", "reliable", "call_local")
func take_damage(amount: int):
	data.hp = max(data.hp - amount, 0)
	update_view()
	if data.hp <= 0:
		get_parent().queue_free()



func heal(amount: int):
	data.hp = min(data.hp + amount, data.max_hp)
	update_view()

func update_view():
	hp_label.update_hp(data.hp)
