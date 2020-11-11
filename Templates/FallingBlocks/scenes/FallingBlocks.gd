extends Node2D

export(PackedScene) var RockBlock
# export(Array, Texture) var textures
# export(Array, AudioStream) var audios

var blocks = []

var expectedArt = -2
var playTimes = 3

func _ready():
	randomize()
	randExpected()
	for x in range(0, 8):
		for y in range(0, 5):
			initBlock(x, 3 - y)
	$AudioWord.play()

func randExpected():
	expectedArt = randi() % Art.textures.size()
	$AudioWord.stream = Art.audios[expectedArt]
	
func initBlock(x, y):
	var block = RockBlock.instance()
	block.position = Vector2(150+ x * 100, y * 150)
	var rnr = randi() % Art.textures.size()
	block.art = Art.textures[rnr]
	block.audio = Art.audios[rnr]
	block.artId = rnr
	block.connect("touch", self, "_on_block_touch", [block])
	add_child(block)

func _on_block_touch(block):
	if block.artId != expectedArt:
		$AudioError.play()
		block.playWrong()
		return;

	var x = (block.position.x - 150) / 100
	initBlock(x, -1)
	# block.playAudio()
	block.playDestroy()

func _on_TimerSayTheWord_timeout():
	playTimes -= 1
	if playTimes == 0:
		playTimes = 2
		randExpected()
	if !$AudioWord.playing:
		$AudioWord.play()

func _on_AudioWord_finished():
	
	$TimerSayTheWord.start()
