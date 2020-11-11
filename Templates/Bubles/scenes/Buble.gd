extends RigidBody2D

export(bool) var correct = false
export(Texture) var art = null
export(AudioStream) var stream = null

signal pop
var rnd = RandomNumberGenerator.new()

func _ready():
	$Buble/Art.texture = art
	$AudioSay.stream = stream
	rnd.randomize()
	var scl = rnd.randf_range(.3, 1)
	var sclV = Vector2(scl, scl)
	$CollisionShape2D.scale = sclV
	$Buble.scale = sclV
	$Explosion.scale = sclV
	pass
	
func _on_Baloon_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$Buble.visible = false
		$Explosion.visible = true
		$AnimationPlayer.play("pop")
		$CollisionShape2D.disabled = true
		$AudioPop.play()


func _on_AudioPop_finished():
	visible = false
	if $AudioSay.stream:
		$AudioSay.play()
	else:
		_on_AudioSay_finished()

func _on_AudioSay_finished():
	emit_signal('pop')
	queue_free()
