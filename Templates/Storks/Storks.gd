extends Node2D

var rnd = RandomNumberGenerator.new()

var stork = preload("res://Stork.tscn")
var wantedObjectId = -1

var max_objects = 3
var objids = []

var points = 0


func _ready():
	rnd.randomize()
	_init_game()

func _init_game():
	objids = shuffleList(range(0, Art.textures.size() - 1))
	wantedObjectId = objids[rnd.randi_range(0, max_objects - 1)]
	$AudioWord.stream = Art.audios[wantedObjectId]
	$Timer.start()
	$AudioWord.play()
	$TimerWord.start()

func _on_Timer_timeout():
	if rnd.randi_range(0, 1):
		return
	
	var st = stork.instance()
	st.objectId = objids[rnd.randi_range(0, max_objects - 1)]
	st.art = Art.textures[st.objectId]
	st.position = Vector2(1023, rnd.randi_range(20, 500))
	add_child(st)

func shuffleList(list):
	var shuffledList = []
	var indexList = range(list.size())
	for _i in range(list.size()):
		randomize()
		var x = randi()%indexList.size()
		shuffledList.append(list[x])
		indexList.remove(x)
		list.remove(x)
	return shuffledList


func _on_TimerWord_timeout():
	if (!$AudioWord.playing):
		$AudioWord.play()


func _on_TimerInitGame_timeout():
	_init_game()
