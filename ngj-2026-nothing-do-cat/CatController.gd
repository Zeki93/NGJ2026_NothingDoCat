extends CharacterBody2D


var speed = 4;
var jumpSpeed = 8;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity += Vector2.DOWN * 10;
	get_input()
	move_and_slide()


func _input(event):
	if event.is_action_pressed("left"):
		#velocity.x = Vector2.LEFT.x * 32 * 2;
		pass
	else: if event.is_action_pressed("right"):
		#velocity.x = Vector2.RIGHT.x * 32 * 2;
		pass
	else:
		velocity.x = 0;
	if event.is_action_pressed("jump"):
		velocity.y = Vector2.UP.y * 32 * jumpSpeed;
		pass
		


func get_input():
	var move = transform.x * Input.get_axis("left", "right") * 32 * speed
	velocity.x = move.x
