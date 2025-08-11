extends CharacterBody2D


const SPEED = 140
const JUMP_VELOCITY = -300.0
var is_dead = false;

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $jumpSound

func die():
	is_dead = true;
	animated_sprite.play("death");

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play();

	# Get input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flips the sprite:
	if direction > 0:
		animated_sprite.flip_h = false;
	if direction < 0:
		animated_sprite.flip_h = true;
	
	# Play animations:
	if is_dead:
		pass;
	elif Engine.time_scale == 0.5:
		die();
	elif is_on_floor():
		if direction == 0:
			animated_sprite.play("idle");
		else:
			animated_sprite.play("run");
	else:
		animated_sprite.play("jump");

	# Apply movement:
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
