extends Node2D

var meowSounds = []
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer;

func _ready() -> void:
	GlobalSignalBus.meow.connect(_on_meow);
	
	for i in 18:
		var soundFile = load("res://Assets/Audio/meow" + str(i) + ".wav")
		meowSounds.push_front(soundFile)

func _on_meow():
	print("play meow sound")
	meowSounds.shuffle();
	var meow = meowSounds.get(0) as AudioStream;
	audio_player.stream = meow;
	audio_player.play();
	pass
