extends RigidBody2D

export(Texture) var art
export(AudioStream) var audio

signal touch
var artId = -1

var audioKnocks = [
	preload("res://assets/audio/sfx/footstep_concrete_000.wav"),
	preload("res://assets/audio/sfx/footstep_concrete_001.wav"),
	preload("res://assets/audio/sfx/footstep_concrete_002.wav"),
	preload("res://assets/audio/sfx/footstep_concrete_003.wav"),
	preload("res://assets/audio/sfx/footstep_concrete_004.wav"),
	]
	
func _ready():
	$Collision/Art.texture = art
	$Audio.stream = audio

func _on_RockBlock_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("touch")
		

func playDestroy():
	playKnock()
	$Collision.disabled = true
	$AnimationPlayer.play("explode")

func playAudio():
	$Audio.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()

func playKnock():
	$AudioKnock.stream = audioKnocks[randi() % audioKnocks.size()]
	$AudioKnock.play()

func _on_RockBlock_body_entered(body):
	playKnock()

func playWrong():
	$AnimationPlayer.play("wrong")
	
func _on_RockBlock_body_shape_entered(body_id, body, body_shape, local_shape):
	playKnock()
