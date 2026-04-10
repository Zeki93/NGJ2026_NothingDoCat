extends CharacterBody2D




func _physics_process(delta: float) -> void:
	velocity = Vector2.UP * Globals.catTileSize.y * 5;
	move_and_slide()

"""
func _input(event):
	if event.is_action_pressed("left"):
		rotation_degrees = 0;
	else: if event.is_action_pressed("right"):
		rotation_degrees = 180;
	else: if event.is_action_pressed("up"):
		rotation_degrees = 90;
	else: if event.is_action_pressed("down"):
		rotation_degrees = 270;
"""
