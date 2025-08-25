extends Node

@export var server_create_popup: PackedScene

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")

func _on_join_pressed() -> void:
	pass # Replace with function body.
	
func _on_create_pressed() -> void:
	var server_create_popup_instance = server_create_popup.instantiate()
	get_tree().current_scene.add_child(server_create_popup_instance)
	var viewport_size = get_viewport().get_visible_rect().size
	server_create_popup_instance.position = Vector2i(viewport_size) - server_create_popup_instance.size
	server_create_popup_instance.position /= 2
