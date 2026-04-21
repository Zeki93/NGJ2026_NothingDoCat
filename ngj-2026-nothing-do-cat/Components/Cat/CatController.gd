extends Node2D

@onready var emoji_sprite = $CharacterBody2D/Emoji
@onready var animated_sprite = $CharacterBody2D/AnimatedSprite2D
@onready var character_body = $CharacterBody2D
@onready var collision_shape = $CharacterBody2D/CollisionShape2D
@export var speed = 2;
@export var jumpSpeed = 7;



var loaf_timer_threshold = 2;
var loaf_timer = 2;

enum states
{
	IDLE,
	MOVING
}
var state : states

func _ready() -> void:
	emoji_sprite.animation = "HEART"
	state = states.IDLE
	animated_sprite.animation = "LOAF"
	GlobalSignalBus.humanReactToCat.connect(_on_cuddle);
	pass

func _physics_process(delta: float) -> void:
	if(Globals.gameEnd):
		animated_sprite.visible = false
		pass
	else:
		_run_simulation(delta);

func _run_simulation(delta: float):
	character_body.velocity += Vector2.DOWN * 10;
	get_input()
	character_body.move_and_slide()
	do_animation(character_body.velocity, delta)
	CatHelper.checkAndUpdateMeow(delta);
	Globals.catPosition = character_body.global_position;

func _input(event):
	if(!Globals.gameEnd):
		if event.is_action_pressed("jump") && character_body.is_on_floor():
			character_body.velocity.y = Vector2.UP.y * Globals.tileSize.y * jumpSpeed;
			GlobalSignalBus.CatJump.emit();
			character_body.set_collision_mask_value(2, false);
			pass
		else:
			character_body.set_collision_mask_value(2, true);
			pass
			#collision_shape.set_collision_layer_value(1, true)
		
		if event.is_action_pressed("meow"):
			CatHelper.meow(emoji_sprite);

func do_animation(velocity: Vector2, delta: float):
	if(velocity == Vector2.ZERO):
		state = states.IDLE
		loaf_timer += delta;
		if(loaf_timer > loaf_timer_threshold):
			animated_sprite.animation = "LOAF"
			animated_sprite.stop()
			animated_sprite.position.y = 6
		else:
			animated_sprite.animation = "IDLE"
			animated_sprite.stop()
			print(animated_sprite.position.y);
			print(Globals.catPosition.y);
			animated_sprite.position.y = 0
	else: 
		loaf_timer = 0;
		animated_sprite.position.y = 0
		if (!character_body.is_on_floor() && velocity.y < 0):
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

func _on_cuddle():
	pass
