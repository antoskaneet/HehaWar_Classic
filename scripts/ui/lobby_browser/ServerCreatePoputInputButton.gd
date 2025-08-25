extends Node

func _on_confirm_pressed() -> void:
	print("конфирм")
	var server_name = get_parent().get_node("MarginContainer/VBoxContainer/ServerName").text
	var server_password = get_parent().get_node("MarginContainer/VBoxContainer/ServerPassword").text
	if server_name != null and server_name != "" and server_password != null:
		LobbyData.is_host = true
		LobbyData.server_name = server_name
		LobbyData.password = server_password
		get_tree().change_scene_to_file("res://scenes/ui/lobby/Lobby.tscn")

func _on_cancel_pressed() -> void:
	print("отмена")
