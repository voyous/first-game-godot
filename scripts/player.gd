extends CharacterBody2D


const SPEED = 140
const JUMP_VELOCITY = -300.0
var is_dead = false;
var createdAttack = preload("res://scenes/attack.tscn");
var currentDirection = 0;

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $jumpSound
@onready var attack_sound: AudioStreamPlayer2D = $attackSound

func die():
	is_dead = true;
	animated_sprite.play("death");
	
func createAttack():
	var new_attack = createdAttack.instantiate();
	add_child(new_attack);
	if currentDirection == 1:
		new_attack.position.x = 14;
		var sprite = new_attack.get_node("AnimatedSprite2D");
		sprite.flip_h = false;
	elif currentDirection == -1:
		new_attack.position.x = -14;
		var sprite = new_attack.get_node("AnimatedSprite2D");
		sprite.flip_h = true;

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
	
	# Creates attack instance infront of character
	if Input.is_action_just_pressed("attack"):
		createAttack();
		attack_sound.play();
	
	# Flips the sprite:
	if direction > 0:
		animated_sprite.flip_h = false;
		currentDirection = 1;
	if direction < 0:
		animated_sprite.flip_h = true;
		currentDirection = -1;
	
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
