extends Node2D

@onready var animated_sprite = $CharacterBody2D/AnimatedSprite2D
@onready var character_body = $CharacterBody2D
@export var speed = 2;
@export var jumpSpeed = 7;

@export var meow_cooldown = 1;
var meow_ready = false;
var meow_timer = 0;
signal meow;


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
	character_body.velocity += Vector2.DOWN * 10;
	get_input()
	character_body.move_and_slide()
	do_animation(character_body.velocity)
	Globals.catPosition = global_position;

func _input(event):
	if event.is_action_pressed("jump"):
		character_body.velocity.y = Vector2.UP.y * Globals.tileSize.y * jumpSpeed;
		pass
		
	if event.is_action_pressed("meow"):
		meow.emit()
		meow_ready = false
		print("meow");

func do_animation(velocity: Vector2):
	if(velocity == Vector2.ZERO):
		animated_sprite.animation = "IDLE"
		animated_sprite.stop()
		state = states.IDLE
	else: if (!character_body.is_on_floor() && velocity.y < 0):
		animated_sprite.play("JUMPING")
		pass
	else: if (!character_body.is_on_floor() && velocity.y > 0):
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

func updateMeow(delta: float):
	if(!meow_ready):
		meow_timer += delta;
		if(meow_timer > meow_cooldown):
			meow_ready = true;
			meow_timer = 0;
	

func get_input():
	var move = transform.x * Input.get_axis("left", "right") * Globals.tileSize.x * speed
	character_body.velocity.x = move.x
