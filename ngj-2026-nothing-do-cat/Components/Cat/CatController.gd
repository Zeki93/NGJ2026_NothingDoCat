extends Node2D

@onready var emoji_sprite = $CharacterBody2D/Emoji
@onready var animated_sprite = $CharacterBody2D/AnimatedSprite2D
@onready var character_body = $CharacterBody2D
@export var speed = 2;
@export var jumpSpeed = 7;

enum states
{
	IDLE,
	MOVING
}
var state : states

func _ready() -> void:
	emoji_sprite.animation = "HEART"
	state = states.IDLE
	GlobalSignalBus.meow.connect(_on_meow)
	pass

func _physics_process(delta: float) -> void:
	character_body.velocity += Vector2.DOWN * 10;
	get_input()
	character_body.move_and_slide()
	do_animation(character_body.velocity)
	CatHelper.checkAndUpdateMeow(delta);
	Globals.catPosition = character_body.global_position;

func _input(event):
	if event.is_action_pressed("jump"):
		character_body.velocity.y = Vector2.UP.y * Globals.tileSize.y * jumpSpeed;
		pass
		
	if event.is_action_pressed("meow"):
		CatHelper.meow(emoji_sprite);

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
	

func get_input():
	var move = transform.x * Input.get_axis("left", "right") * Globals.tileSize.x * speed
	character_body.velocity.x = move.x
	

func _on_meow():
	# Your code here…
	print("Human Heard Meow")
	pass
