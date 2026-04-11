class_name Emoji
extends Node2D

@onready var animated_sprite = $AnimatedSprite2D;
var emojiDuration = 5;
var emojiTimer = 0;

func _process(delta: float) -> void:
	animated_sprite.global_position = Vector2(50,100);
	pass
	#emojiTimer += delta;
	#if(emojiTimer > emojiDuration):
	#	queue_free()

func _ShowAnimation(animation: String):
	animated_sprite.animation = animation;
	animated_sprite.play(animation);
	pass
