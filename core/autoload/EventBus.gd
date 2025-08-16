extends Node

signal unit_input_right_click(unit_input: Node, unit_input_right_click: String)
signal grass_input_selected(grass_input: Node)
signal unit_input_target_right_click(unit_input: Node, unit_input_target_right_click: String)

signal unit_input_selected(unit_input: Node)
signal unit_input_attacked_selected(unit_input: Node)

signal set_movement_area(unit: Node)
signal move(grass: Node)
signal clear_movement_area()

signal set_attack_area(unit)
signal attack(unit)
signal clear_attack_area()
