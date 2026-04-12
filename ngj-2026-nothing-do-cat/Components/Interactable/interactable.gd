class_name interactable
extends Node2D

@export var interactRange = 16;
@export var humanInteractable = false;
@export var catTnteractable = false;
@export var catMeowable = false;
@export var human_interact_type: human_interact_types;
@export var human_reaction_type: human_reaction_types

@onready var before_interact = $Before;
@onready var before_interact_collsion = $Before/CollisionShape2D;
@onready var after_interact = $After;

var hasInteracted = false;
signal humanReactToCat;

var item_position : Vector2;

enum human_reaction_types{
	GO_TO_CAT_CUDDLE,
	GO_TO_ITEM_ANNOYED,
	GO_TO_ITEM_HAPPY,
	GO_TO_ITEM_ANGRY,
}

enum human_interact_types{
	IDLE,
	WORKING
}

func _ready() -> void:
	item_position = global_position;
	GlobalSignalBus.meow.connect(_on_meow)
	pass
	
func _process(delta: float) -> void:
	item_position = global_position;

func _cat_in_range():
	return abs(Globals.catPosition.x - global_position.x) < interactRange

func interact():
	if(!hasInteracted):
		before_interact.visible = false
		before_interact_collsion.disabled = true;
		after_interact.visible = true
		GlobalSignalBus.humanReactToCat.emit(self)
		hasInteracted = true
	pass

func _on_meow():
	if(catMeowable && _cat_in_range()):
		interact();
	pass
