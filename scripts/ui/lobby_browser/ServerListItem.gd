extends Node

func set_data(server_name):
	get_node("HBoxContainer/HboxContainerLeft/LabelServerName").text = server_name
