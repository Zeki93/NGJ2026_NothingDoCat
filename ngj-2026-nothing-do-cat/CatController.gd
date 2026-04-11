extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var speed = 2;
@export var jumpSpeed = 7;

enum states
{
	IDLE,
	MOVING
}
var state : states

func _ready() -> void:
	state = states.IDLE
	pass

func _physics_process(delta: float) -> void:
	velocity += Vector2.DOWN * 10;
	get_input()
	move_and_slide()
	do_animation(velocity)
	Globals.catPosition = global_position;

func _input(event):
	if event.is_action_pressed("jump"):
		velocity.y = Vector2.UP.y * Globals.tileSize.y * jumpSpeed;
		pass

func do_animation(velocity: Vector2):
	if(velocity == Vector2.ZERO):
		animated_sprite.animation = "IDLE"
		animated_sprite.stop()
		state = states.IDLE
	else: if (!is_on_floor() && velocity.y < 0):
		animated_sprite.play("JUMPING")
		pass
	else: if (!is_on_floor() && velocity.y > 0):
		animated_sprite.play("FALLING")
		pass
	else: if (velocity.x > 0):
		animated_sprite.flip_h = false
		animated_sprite.play("MOVING")
		state = states.MOVING;
	else: if (velocity.x < 0):
		animated_sprite.flip_h = true
		animated_sprite.play("MOVING")
		state = states.MOVING;

func get_input():
	var move = transform.x * Input.get_axis("left", "right") * Globals.tileSize.x * speed
	velocity.x = move.x


func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite.play("MOVING");
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_changed() -> void:
	pass # Replace with function body.
