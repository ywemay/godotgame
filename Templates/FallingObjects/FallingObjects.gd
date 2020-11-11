extends Node2D

var rnd = RandomNumberGenerator.new()

var FallingO = preload("res://FallingObject.tscn")
var wantedObjectId = -1

var max_objects = 3
var objids = []

var points = [0, 0]
var mode = 2 # 1 single 2 double

# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()
	_init_game()

func _init_game():
	if mode == 1:
		$DevidingLine.visible = false
		$DevidingLine/Area2D/CollisionShape2D.disabled = true
	elif mode == 2:
		$DevidingLine.visible = true
		$DevidingLine/Area2D/CollisionShape2D.disabled = false
	
	objids = shuffleList(range(0, Art.textures.size()))
	wantedObjectId = objids[rnd.randi_range(0, max_objects - 1)]
	$AudioWord.stream = Art.audios[wantedObjectId]
	$Timer.start()
	$AudioWord.play()
	$TimerWord.start()
	
func _on_Timer_timeout():
	var o = FallingO.instance()
	o.position = Vector2(rnd.randi_range(100, get_viewport_rect().end.x-20), -50)
	
	o.objectId = objids[rnd.randi_range(0, max_objects - 1)]
	o.art = Art.textures[o.objectId]
	o.connect("points", self, "_on_points")
	if mode == 2:
		if o.position.x <= 512:
			if o.position.x > 480:
				o.position.x = 480
			$Team1.add_child(o)
		else:
			if o.position.x < 512 + 32:
				o.position.x = 512 + 32
			$Team2.add_child(o)
	else:
		$Team1.add_child(o)

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

func _on_TimerResetGame_timeout():
	_init_game()
	
func _get_graded_color(points):
	var color
	if points < 0:
		color = Color(255, 0, 0 , 255)
	elif points == 0:
		color = Color(120, 120, 120, 255)
	elif points < 50:
		color = Color(40, 120, 120, 255)
	elif points < 100:
		color = Color(0, 120, 120, 255)
	else: 
		color = Color(0, 255, 0 , 255)
	return color

func _on_points(p, fo):
	if (fo.get_parent().name == "Team1"):
		points[0] += p
		$LabelPoints.text = String(points[0])
		$LabelPoints.add_color_override("font_color", _get_graded_color(points[0]));
	if (fo.get_parent().name == "Team2"):
		points[1] += p
		$LabelPoints2.text = String(points[1])
		$LabelPoints2.add_color_override("font_color", _get_graded_color(points[1]));
