extends Node

func _on_exit_button_pressed() -> void:
	print("Exit")

func _on_setting_button_pressed() -> void:
	print("Setting")

func _on_mulitplayer_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/lobby_browser/LobbyBrowser.tscn")

func _on_singleplayer_button_pressed() -> void:
	print("Singleplayer")
