extends RigidBody2D

export(bool) var correct = false
export(Texture) var texture = null
export(Texture) var art = null
export(AudioStream) var stream = null

signal pop

func _ready():
	$Baloon.texture = texture
	$Baloon/Art.texture = art
	$AudioSay.stream = stream
	pass
	
func _on_Baloon_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$Baloon.visible = false
		$Explosion.visible = true
		$AudioPop.play()


func _on_AudioPop_finished():
	$CollisionShape2D.disabled = true
	$AudioSay.play()
	visible = false
	

func _on_AudioSay_finished():
	emit_signal('pop')
	queue_free()
