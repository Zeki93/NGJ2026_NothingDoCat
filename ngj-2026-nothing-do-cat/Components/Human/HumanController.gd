extends Node2D

@onready var characterBody = $CharacterBody2D
@onready var animated_sprite = $CharacterBody2D/AnimatedSprite2D
@onready var emoji_sprite = $CharacterBody2D/Emoji
@onready var interactables = $"../World/Interactables"

enum states
{
	IDLE = 0,
	MOVING = 1,
	WORKING = 2,
	INTERRUPTED = 3
}
var state : states

@export var speed = 1.5
@export var offset = 2;
@export var idleTime = 15;
@export var interruptTime = 5
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
	workTargets.shuffle()

func _ready() -> void:
	state = states.IDLE;
	animated_sprite.animation = "IDLE" 
	characterBody.global_position.x = startPosition;
	characterBody.global_position.y = standingHeight;
	Globals.humanPosition = characterBody.global_position
	call_deferred("do_setup")
	GlobalSignalBus.humanReactToCat.connect(_on_cat_interrupt)
	stateTime = 10;

func _process(delta: float) -> void:
	stateTime += delta;
	
	match(state):
		states.IDLE:
			if(stateTime > idleTime):
				_change_state_to_moving();
				getNextTargetPosition();
				pass
		states.MOVING:
			if(hasReachedTarget()):
				if(target.human_interact_type == target.human_interact_types.IDLE):
					_change_state_to_idle()
				else:
					_change_state_to_working()
			else:
				moveToTarget();
		states.INTERRUPTED:
			if(hasReachedTarget()):
				match(target.human_reaction_type):
					target.human_reaction_types.GO_TO_CAT_CUDDLE:
						if(abs(Globals.catPosition.x - Globals.humanPosition.x) < Globals.catTileSize.x/2):
							_change_state_to_idle();
							EmotionController.showHumanEmoji(emoji_sprite, "HEART");
							GlobalSignalBus.CuddleCat.emit();
							pass
						else:
							EmotionController.showHumanEmoji(emoji_sprite, "ANNOYED");
							_change_state_to_idle();
					target.human_reaction_types.GO_TO_ITEM_HAPPY:
						_change_state_to_idle();
						EmotionController.showHumanEmoji(emoji_sprite, "HAPPY");
						pass
					target.human_reaction_types.GO_TO_ITEM_ANNOYED:
						EmotionController.showHumanEmoji(emoji_sprite, "ANNOYED");
						_change_state_to_idle();
						pass
					target.human_reaction_types.GO_TO_ITEM_ANGRY:
						EmotionController.showHumanEmoji(emoji_sprite, "ANGRY");
						_change_state_to_idle();
						pass
				stateTime = idleTime - interruptTime;
			else:
				moveToTarget();
				_play_moving_animation();
			pass
	characterBody.move_and_slide()
	Globals.humanPosition = characterBody.global_position;

func moveToTarget():
	if(target.item_position.x > Globals.humanPosition.x):
		#Moving Right
		animated_sprite.flip_h = true
		characterBody.velocity.x = Globals.tileSize.x * speed;
	else:
		#Moving Left
		characterBody.velocity.x = -Globals.tileSize.x * speed;
		animated_sprite.flip_h = false

func hasReachedTarget():
	var distanceFromTarget = Globals.humanPosition.x - target.item_position.x
	return abs(distanceFromTarget) < offset;

func getNextTargetPosition(skip = false):
	var newTarget = workTargets.pop_front();
	if(skip == false && target != null && target.item_position.x != 0 ):
		workTargets.push_back(target);
	if(newTarget != null):
			target = newTarget;
		
func _on_cat_interrupt(item: interactable):
	if(state != states.INTERRUPTED):
		state = states.INTERRUPTED;
		target = item;
		EmotionController.showHumanEmoji(emoji_sprite, "INTERRUPTED");
		Globals.human_interrupted_counter += 1;
	pass
	
func _change_state_to_idle():
	state = states.IDLE;
	animated_sprite.stop();
	animated_sprite.animation = "IDLE"
	_stop_moving();
	
func _change_state_to_working():
	state = states.WORKING;
	animated_sprite.stop();
	animated_sprite.animation = "WORKING"
	_stop_moving();

func _stop_moving():
	stateTime = 0;
	characterBody.global_position.y = standingHeight;
	characterBody.velocity.x = 0;

func _change_state_to_moving():
	stateTime = 0;
	state = states.MOVING;
	_play_moving_animation()
	
func _play_moving_animation():
	animated_sprite.animation = "MOVING";
	animated_sprite.play("MOVING");
	characterBody.global_position.y = walkingHeight;
