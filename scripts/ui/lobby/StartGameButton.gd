extends Button

func _on_pressed() -> void:
	if multiplayer.is_server():
		start_game.rpc()

@rpc("authority", "reliable", "call_local")
func start_game():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
