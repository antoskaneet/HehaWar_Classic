extends Node

@onready var inputunit: Area2D = get_parent().get_node("InputUnit") 

func activate():
	inputunit.enable_attacked_event()

func un_activate():
	inputunit.disable_attacked_event()
