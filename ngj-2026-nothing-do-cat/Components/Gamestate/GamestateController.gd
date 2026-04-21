extends Node2D

@export var interrupts_to_end_game = 4;
var bedroomDoorOpened = false;
@onready var door_sprite = $Door/StaticBody2D/Sprite2D;
@onready var door_collision = $Door/StaticBody2D/CollisionShape2D
@onready var endscreen_menu_button = $"../EndMenu/Menu";
@onready var endscreen_next_day_button = $"../EndMenu/NextDay";


var endscreen_menu_timer = 0;
var show_menu_after_seconds = 5;
var delay = 0.5;

func _process(delta: float) -> void:
	if(Globals.gameEnd):
		endscreen_menu_timer += delta;
		if(endscreen_menu_timer > show_menu_after_seconds):
			endscreen_next_day_button.visible = true;
		if(endscreen_menu_timer > show_menu_after_seconds + delay):
			endscreen_menu_button.visible = true;
	else:
		endscreen_menu_button.visible = false;
		endscreen_next_day_button.visible = false;
		check_for_game_end();
	

func check_for_game_end():
	if(Globals.human_interrupted_counter >= interrupts_to_end_game):
		if(!bedroomDoorOpened):
			_open_bedroom_door()
	if(bedroomDoorOpened):
		if(Globals.catPosition.x > Globals.screenSize.x * 2):
			end_game();
		
func end_game():
	Globals.gameEnd = true;
	pass

func _open_bedroom_door():
	bedroomDoorOpened = true;
	door_sprite.visible = false;
	door_collision.disabled = true;
	pass
