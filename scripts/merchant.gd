extends Node2D

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var rand = RandomNumberGenerator.new();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(rand.randf_range(0.1, 1.5));

func _on_timer_timeout() -> void:
	if animated_sprite.flip_h == true:
		animated_sprite.flip_h = false;
	else:
		animated_sprite.flip_h = true;
		
	timer.start(rand.randf_range(0.5, 3));
