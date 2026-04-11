extends Node2D

@onready var characterBody = $CharacterBody2D
@onready var animated_sprite = $CharacterBody2D/AnimatedSprite2D
@onready var interactables = $"../World/Interactables"

enum states
{
	IDLE = 0,
	MOVING = 1,
	WORKING = 2,
}
var state : states

@export var speed = 1.5
@export var offset = 2;
@export var idleTime = 15;
var workTargets = [];

var startPosition = 200
var standingHeight = 144
var walkingHeight = 146;

var target : interactable;
var stateTime = 0;

func do_setup() -> void:
	for child in interactables.get_children():
		if(child is interactable):
			if(child.humanInteractable == true):
				workTargets.push_front(child);
			pass
		pass

func _ready() -> void:
	state = states.IDLE;
	animated_sprite.animation = "IDLE" 
	characterBody.global_position.x = startPosition;
	characterBody.global_position.y = standingHeight;
	Globals.humanPosition = characterBody.global_position
	call_deferred("do_setup")

func _process(delta: float) -> void:
	stateTime += delta;
	
	match(state):
		states.IDLE:
			if(stateTime > idleTime):
				stateTime = 0;
				state = states.MOVING;
				animated_sprite.animation = "MOVING";
				animated_sprite.play("MOVING");
				characterBody.global_position.y = walkingHeight;
				#PLACEHOLDER LOGIC
				getNextTargetPosition();
				pass
		states.MOVING:
			var distanceFromTarget = Globals.humanPosition.x - target.item_position.x
			if(abs(distanceFromTarget) < offset):
				stateTime = 0;
				if(target.human_interact_type == target.human_interact_types.IDLE):
					state = states.IDLE;
					animated_sprite.stop();
					animated_sprite.animation = "IDLE"
				else:
					state = states.WORKING;
					animated_sprite.stop();
					animated_sprite.animation = "WORKING"
				characterBody.global_position.y = standingHeight;
				characterBody.velocity.x = 0;
			else:
				if(target.item_position.x > Globals.humanPosition.x):
					#Moving Right
					animated_sprite.flip_h = true
					characterBody.velocity.x = Globals.tileSize.x * speed;
				else:
					#Moving Left
					characterBody.velocity.x = -Globals.tileSize.x * speed;
					animated_sprite.flip_h = false
	
	characterBody.move_and_slide()
	Globals.humanPosition = characterBody.global_position;

func getNextTargetPosition():
	if(target != null && target.item_position.x != 0):
		workTargets.push_back(target);
	var newTarget = workTargets.pop_front();
	if(newTarget != null):
			target = newTarget;
