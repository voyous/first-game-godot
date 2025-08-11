extends Node

var score = 0;
var player_has_weapon = false;
@onready var score_label: Label = $ScoreLabel;
@onready var merchant_text_box: Label = $merchantTextBox
@onready var slime: Node2D = $slime

# Add 1 to score and update world text
func add_point() -> void:
	score += 1;
	score_label.text = "You collected " + str(score) + " coins";

# Update merchant textbox
func update_merch_text(text):
	merchant_text_box.text = text;

# Return score value
func check_score():
	return score;

# Enables weapon for player
func enable_weapon():
	player_has_weapon = true;

# Return value for player_has_weapon
func check_weapon_is_enabled():
	return player_has_weapon;
