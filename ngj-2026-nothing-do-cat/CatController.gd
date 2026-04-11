extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var speed = 2;
var jumpSpeed = 7;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity += Vector2.DOWN * 10;
	get_input()
	move_and_slide()


func _input(event):
	if event.is_action_pressed("left"):
		animated_sprite.flip_h = true
		pass
	else: if event.is_action_pressed("right"):
		animated_sprite.flip_h = false
		pass
	else:
		velocity.x = 0;
	if event.is_action_pressed("jump"):
		velocity.y = Vector2.UP.y * 32 * jumpSpeed;
		pass
		


func get_input():
	var move = transform.x * Input.get_axis("left", "right") * 32 * speed
	velocity.x = move.x
