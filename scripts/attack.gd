extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var anim_is_playing = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !animated_sprite.is_playing():
		queue_free();


#func _on_area_entered(body: Node2D) -> void:
	


func _on_area_entered(area: Area2D) -> void:
	if area.name == "killzone":
		area.get_parent().lower_health();
