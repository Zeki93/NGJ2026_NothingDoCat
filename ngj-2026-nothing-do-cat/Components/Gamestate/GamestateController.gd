extends Node2D

@export var interrupts_to_end_game = 4;
var bedroomDoorOpened = false;
@onready var door_sprite = $Door/StaticBody2D/Sprite2D;
@onready var door_collision = $Door/StaticBody2D/CollisionShape2D



func _process(delta: float) -> void:
	if(Globals.human_interrupted_counter >= interrupts_to_end_game):
		if(!bedroomDoorOpened):
			_open_bedroom_door()
	if(bedroomDoorOpened):
		if(Globals.catPosition.x > Globals.screenSize.x * 2):
			print(Globals.catPosition.x);
			end_game();
		
func end_game():
	Globals.gameEnd = true;
	pass

func _open_bedroom_door():
	bedroomDoorOpened = true;
	door_sprite.visible = false;
	door_collision.disabled = true;
	pass
