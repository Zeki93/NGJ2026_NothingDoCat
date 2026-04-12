extends Camera2D

func _ready() -> void:
	global_position.y = Globals.screenSize.y/2;

func _process(delta: float) -> void:
	if(Globals.gameEnd):
		global_position.x = Globals.screenSize.x/2 + Globals.screenSize.x*2
	else:
		follow_cat()

	

func follow_cat():
	if(Globals.catPosition.x > Globals.screenSize.x):
		global_position.x = Globals.screenSize.x/2 + Globals.screenSize.x;
	else:
		global_position.x = Globals.screenSize.x/2;
	pass
