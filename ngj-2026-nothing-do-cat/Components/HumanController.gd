extends Node2D

@onready var characterBody = $CharacterBody2D
@onready var animated_sprite = $CharacterBody2D/AnimatedSprite2D

enum states
{
	IDLE = 0,
	MOVING = 1,
	WORKING = 2,
}
var state : states

@export var speed = 1.5
@export var offset = 2;
@export var idleTime = 5;

@export var startPosition = 200
@export var standingHeight = 144
@export var walkingHeight = 146;

var targetPosition: int;
var placeholderTargets = []

var stateTime = 0;

func _ready() -> void:
	placeholderTargets.push_front(200)
	placeholderTargets.push_front(400)
	placeholderTargets.push_front(100)
	state = states.IDLE;
	animated_sprite.animation = "IDLE" 
	characterBody.global_position.x = startPosition;
	characterBody.global_position.y = standingHeight;
	Globals.humanPosition = characterBody.global_position

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
			var distanceFromTarget = Globals.humanPosition.x - targetPosition
			if(abs(distanceFromTarget) < offset):
				stateTime = 0;
				state = states.IDLE;
				animated_sprite.stop();
				animated_sprite.animation = "IDLE"
				characterBody.global_position.y = standingHeight;
				characterBody.velocity.x = 0;
			else:
				if(targetPosition > Globals.humanPosition.x):
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
	if(targetPosition != null && targetPosition != 0):
		placeholderTargets.push_back(targetPosition);
	var newPos = placeholderTargets.pop_front();
	if(newPos != null):
			targetPosition = newPos;

		
