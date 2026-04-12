extends Node2D

@export var interrupts_to_end_game = 4;
var bedroomDoorOpened = false;


func _process(delta: float) -> void:
	if(Globals.human_interrupted_counter >= interrupts_to_end_game):
		if(!bedroomDoorOpened):
			_open_bedroom_door()
	if(bedroomDoorOpened):
		print(Globals.catPosition.x);
		Globals.catPosition.x > Globals.screenSize.x * 2;
		end_game();
		
func end_game():
	pass

func _open_bedroom_door():
	bedroomDoorOpened = true;
	pass
