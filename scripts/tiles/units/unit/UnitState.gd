extends Node

@onready var input_unit: Area2D = get_parent().get_node("InputUnit") 

func activate():
	input_unit.enable_attacked_event()	
	get_parent().get_node("Sprite2D").texture = preload("res://assets/blackhex.png")

func un_activate():
	input_unit.disable_attacked_event()
	get_parent().get_node("Sprite2D").texture = preload("res://assets/testhexunit.png")
