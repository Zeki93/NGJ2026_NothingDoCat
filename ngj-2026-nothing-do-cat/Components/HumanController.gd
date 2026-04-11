extends Node2D

@onready var characterBody = $CharacterBody2D

enum states
{
	IDLE,
	MOVING,
}
var state : states

@export var speed = 1.5
@export var offset = 2;
@export var idleTime = 5;

var targetPosition: int;
var placeholderTargets = []

var stateTime = 0;

func _ready() -> void:
	placeholderTargets.push_front(200)
	placeholderTargets.push_front(400)
	placeholderTargets.push_front(100)
	state = states.IDLE;

func _process(delta: float) -> void:
	stateTime += delta;
	
	match(state):
		states.IDLE:
			if(stateTime > idleTime):
				stateTime = 0;
				state = states.MOVING;
				print("MOVING")
				
				#PLACEHOLDER LOGIC
				if(targetPosition != null && targetPosition != 0):
					placeholderTargets.push_back(targetPosition);
				var newPos = placeholderTargets.pop_front();
				if(newPos != null):
					targetPosition = newPos;
				pass
		states.MOVING:
			var distanceFromTarget = Globals.humanPosition.x - targetPosition
			if(abs(distanceFromTarget) < offset):
				stateTime = 0;
				state = states.IDLE;
				print("IDLE")
				characterBody.velocity.x = 0;
			else:
				if(targetPosition > Globals.humanPosition.x):
					#Moving Right
					#animated_sprite.flip_h = false
					characterBody.velocity.x = Globals.tileSize.x * speed;
					pass
				else:
					#Moving Left
					characterBody.velocity.x = -Globals.tileSize.x * speed;
				pass
			pass
		pass
	
	characterBody.move_and_slide()
	Globals.humanPosition = characterBody.global_position;
