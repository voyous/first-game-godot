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

# On timer end flip sprite and start new random length timer
func _on_timer_timeout() -> void:
	if animated_sprite.flip_h == true:
		animated_sprite.flip_h = false;
	else:
		animated_sprite.flip_h = true;
		
	timer.start(rand.randf_range(0.5, 3));

func _process(delta: float) -> void:
	# If colliding player can interact to talk to merchant
	if is_colliding:
		if Input.is_action_just_pressed("interact"):
			timer.stop();
			merchant_text_box.text = "I found a sword on the way here... It's yours for 13 coins.";
			animated_sprite.stop();

# On collision body entered, change text and set colliding to true
func _on_area_2d_body_entered(body: Node2D) -> void:
	merchant_text_box.text = "Press E to interact.";
	is_colliding = true;

# On collision body exited, change text to default, start timer again and set colliding to false
func _on_area_2d_body_exited(body: Node2D) -> void:
	merchant_text_box.text = "Weapons for sale!";
	timer.start();
	animated_sprite.play("default");
	is_colliding = false;
