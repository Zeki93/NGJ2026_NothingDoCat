extends Control


func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	Globals.gameEnd = false;
	pass # Replace with function body.

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	Globals.gameEnd = false;
	pass # Replace with function body.
