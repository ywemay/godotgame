extends Node2D

func _ready():
	$AudioCharm.play()
	$AnimationPlayer.play("fly")

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
