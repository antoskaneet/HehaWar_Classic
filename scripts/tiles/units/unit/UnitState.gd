extends Node

@onready var input_unit: Area2D = get_parent().get_node("InputUnit") 
var flag: bool

func activate():
	if InputManager.is_enabled(input_unit, "right_click_select"):
		flag = true
	InputManager.disable_input(input_unit, "right_click_select")
	InputManager.enable_input(input_unit, "right_click_target")
	get_parent().get_node("Sprite2D").texture = preload("res://assets/blackhex.png")

func un_activate():
	InputManager.disable_input(input_unit, "right_click_target")
	if flag:
		InputManager.enable_input(input_unit, "right_click_select")
	get_parent().get_node("Sprite2D").texture = preload("res://assets/testhexunit.png")
