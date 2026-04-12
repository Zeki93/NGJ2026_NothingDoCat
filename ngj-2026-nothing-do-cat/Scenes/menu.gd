extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	Globals.gameEnd = false;


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
