extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setScore(points):
	$Score.text = '' + String(points[0]) + ' : ' + String(points[1])
