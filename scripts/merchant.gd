extends Node2D

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var merchant_text_box: Label = $merchantTextBox

var rand = RandomNumberGenerator.new();
var is_talking = false;
var is_colliding = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(rand.randf_range(0.1, 1.5));

func _on_timer_timeout() -> void:
	if animated_sprite.flip_h == true:
		animated_sprite.flip_h = false;
	else:
		animated_sprite.flip_h = true;
		
	timer.start(rand.randf_range(0.5, 3));

func _process(delta: float) -> void:
	if is_colliding:
		pass;
	else:
		pass;


func _on_area_2d_body_entered(body: Node2D) -> void:
	merchant_text_box.text = "Press E to interact.";
	timer.stop();
	is_colliding = true;


func _on_area_2d_body_exited(body: Node2D) -> void:
	merchant_text_box.text = "Weapons for sale!";
	timer.start();
	is_colliding = false;
