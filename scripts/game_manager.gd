extends Node

var score = 0;
@onready var score_label: Label = $ScoreLabel;
@onready var merchant_text_box: Label = $merchantTextBox

func add_point() -> void:
	score += 1;
	score_label.text = "You collected " + str(score) + " coins";

func update_merch_text(text):
	merchant_text_box.text = text;

func check_score():
	return score;
