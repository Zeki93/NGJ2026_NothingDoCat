class_name interactable
extends Node2D

@export var interactRange = 5;
@export var humanTnteractable = false;
@export var catTnteractable = false;
@export var human_interact_type: human_interact_types;

enum human_interact_types{
	IDLE,
	WORKING
}
	

func _process(delta: float) -> void:
	if(abs(Globals.catPosition.x - global_position.x) < interactRange ):
		print("can Interact")
		pass
