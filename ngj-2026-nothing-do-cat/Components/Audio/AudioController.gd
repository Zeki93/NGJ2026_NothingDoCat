extends Node2D

var meow_sounds = []
@onready var meow_audio_player : AudioStreamPlayer = $Meow_AudioStreamPlayer;
var jump_sounds = []
@onready var jump_audio_player : AudioStreamPlayer = $Jump_AudioStreamPlayer;
var angry_sound = [];
@onready var angry_audio_player : AudioStreamPlayer = $Angry_AudioStreamPlayer;

func _ready() -> void:
	GlobalSignalBus.meow.connect(_on_meow);
	GlobalSignalBus.CatJump.connect(_on_jump);
	GlobalSignalBus.ArzieAngry.connect(_on_angry);
	
	for i in range(1,19):
		var soundFile = load("res://Assets/Audio/meow" + str(i) + ".wav")
		meow_sounds.push_front(soundFile)
	for i in range(1,3):
		var soundFile = load("res://Assets/Audio/JumpBoing" + str(i) + ".wav")
		jump_sounds.push_front(soundFile)
	
	angry_sound .push_front(load("res://Assets/Audio/ArzieScream.mp3"));
	
	
func _on_angry():
	play_sound(angry_audio_player, angry_sound);
	pass

func _on_jump():
	play_sound(jump_audio_player, jump_sounds);
	pass

func _on_meow():
	play_sound(meow_audio_player, meow_sounds);
	pass

func play_sound(audiplayer: AudioStreamPlayer, sounds : Array):
	sounds.shuffle();
	var meow = sounds.get(0) as AudioStream;
	audiplayer.stream = meow;
	audiplayer.play();
	pass
