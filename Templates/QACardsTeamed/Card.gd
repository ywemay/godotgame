extends StaticBody2D

var id = -1

signal click

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setImage(texture):
	$Sprite.texture = texture

func _on_BabyOwl_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("click", self)

func playError():
	$Animation.play("error")

func playRight():
	$Animation.play("right")
