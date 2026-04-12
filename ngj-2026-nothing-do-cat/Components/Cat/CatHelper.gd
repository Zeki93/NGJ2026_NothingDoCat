class_name CatHelper
extends Node

static var meow_ready = true;
static var meow_timer = 0;
static var meow_cooldown = 1;
static var animated_sprite : AnimatedSprite2D;
	
static func checkAndUpdateMeow(delta: float):
	if(!meow_ready):
		meow_timer += delta;
		if(meow_timer > meow_cooldown):
			meow_ready = true;
			meow_timer = 0;
			if(animated_sprite != null):
				animated_sprite.stop();
				animated_sprite.visible = false;

static func meow(cat_animated_sprite: AnimatedSprite2D):
	if(meow_ready):
		GlobalSignalBus.meow.emit()
		EmotionController.showCatEmoji(cat_animated_sprite, "MEOW");
		meow_ready = false
		print("meow");
		return true;
	return false;
