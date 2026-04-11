class_name EmotionController
extends Node2D

static var catEmoji : AnimatedSprite2D;
static var humanEmoji : AnimatedSprite2D;

static var cat_emote_playing = false;
var cat_timer = 0;
var cat_cooldown = 1;

static var human_emote_playing = false;
var human_timer = 0;
var human_cooldown = 2;


func _ready() -> void:
	#_spawnEmoji(Vector2(100,100));
	pass

func _process(delta: float) -> void:
	if(human_emote_playing && humanEmoji != null):
		human_timer += delta
		if(human_timer > human_cooldown):
			humanEmoji.visible = false
			humanEmoji.stop();
			human_timer = 0;
			human_emote_playing = false
	
	if(cat_emote_playing && catEmoji != null):
		cat_timer += delta
		if(cat_timer > cat_cooldown):
			catEmoji.visible = false
			catEmoji.stop();
			cat_timer = 0;
			cat_emote_playing = false

static func showCatEmoji(animated_sprite: AnimatedSprite2D, animation : String):
	catEmoji = animated_sprite;
	cat_emote_playing = true;
	showEmoji(catEmoji, animation);
	
static func showHumanEmoji(animated_sprite: AnimatedSprite2D, animation : String):
	humanEmoji = animated_sprite;
	human_emote_playing = true;
	showEmoji(humanEmoji, animation);

static func showEmoji(animated_sprite: AnimatedSprite2D, animation : String):
	animated_sprite.animation = animation;
	animated_sprite.play(animation);
	animated_sprite.visible = true;
	pass
