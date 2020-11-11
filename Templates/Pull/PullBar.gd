extends RigidBody2D

var objId = -1
var color = "#45603b"

signal click

# Called when the node enters the scene tree for the first time.
func _ready():
	$Line2D.default_color = Color(color)
	pass # Replace with function body.


func _on_PullBar_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("click", self)
