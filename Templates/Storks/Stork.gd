extends RigidBody2D

var PointTen = preload("res://Points10.tscn")

var rnd = RandomNumberGenerator.new()
export(Texture) var art

var objectId = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()
	$StorkArt/Payload.texture = art
	_rand_anim()

func _on_Timer_timeout():
	_rand_anim()
	
func _rand_anim():
	if rnd.randi_range(0, 1):
		$Animation.play("fly")
	else:
		$Animation.play("soar")


func _on_Visibility_screen_exited():
	queue_free()


func _on_Animation_animation_finished(anim_name):
	if rnd.randi_range(0, 2):
		$Animation.play("fly")
	else:
		$Animation.play("soar")


func _on_Stork_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_parent().wantedObjectId == objectId:
			var p10 = PointTen.instance()
			p10.position = position
			get_parent().add_child(p10)
			emit_signal("points", 10)
			queue_free()
		else:
			$AnimationPlayer.play("wrong")
			# var p10 = MinusTen.instance()
			# p10.position = Vector2(100, 60)
			# get_parent().add_child(p10)
			# emit_signal("points", -10)
			$AudioError.play()
			# $Animation.play("wrong")
