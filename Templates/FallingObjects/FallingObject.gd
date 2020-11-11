extends RigidBody2D

export(Texture) var art

var PointTen = preload("res://Points10.tscn")
var MinusTen = preload("res://minus10.tscn")
var objectId = -1

signal points

func _ready():
	$Art.texture = art

func _on_Visibility_screen_exited():
	queue_free()

func _on_FallingObject_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_parent().get_parent().wantedObjectId == objectId:
			var p10 = PointTen.instance()
			p10.position = position
			get_parent().add_child(p10)
			emit_signal("points", 10, self)
			queue_free()
		else:
			$Collision.disabled = true
			var p10 = MinusTen.instance()
			p10.position = position
			get_parent().add_child(p10)
			emit_signal("points", -10, self)
			$AudioError.play()
			$Animation.play("wrong")
