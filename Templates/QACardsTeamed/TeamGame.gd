extends Node2D

var ids1 = range(0, 6)
var ids2 = range(0, 6)
var id = 0
var canAnswer = [ false, false ]
var answers = [-1, -1]

var points = [0, 0]
var cardsCount = 0

var card = preload("res://Card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var c
	cardsCount = Art.textures.size()
	ids1 = range(0, cardsCount)
	ids2 = range(0, cardsCount)
	for i in range(0, Art.textures.size()):
		c = card.instance()
		c.id = i
		c.setImage(Art.textures[i])
		c.connect("click", self, "_on_card_click")
		$Team1.add_child(c)
		c = card.instance()
		c.id = i
		c.setImage(Art.textures[i])
		c.connect("click", self, "_on_card_click")
		$Team2.add_child(c)
	initGame()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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

func _on_Owl_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		startGame()
		
func initGame():
	ids1 = shuffleList(ids1)
	ids2 = shuffleList(ids2)
	id = randi() % cardsCount
	var j = -1
	for i in range(0, cardsCount):
		if !i%3:
			j += 1
		$Team1.get_child(ids1[i]).position = Vector2(i % 3 * 100 + 150, j * 100 + 350)
	j = -1
	for i in range(0, cardsCount):
		if !i%3:
			j += 1
		$Team2.get_child(ids2[i]).position = Vector2(i % 3 * 100 + 650, j * 100 + 350)

func startGame():
	if $AudioQ.playing:
		return
	initGame()
	$AudioQ.stream = Art.audios[id]
	$AudioQ.play()
	canAnswer = [ true, true ]
	answers = [ -1, -1 ]

func _on_points10_animation_finished(anim_name):
	$Points10.hide()

func _on_card_click(c):
	var answerBy = c.get_parent().name
	if answerBy == 'Team1':
		updateTeamAnswer(c, 0, id == c.id)
	elif answerBy == 'Team2':
		updateTeamAnswer(c, 1, id == c.id)

func updateTeamAnswer(c, teamId, result):
	if (answers[teamId] != -1):
		 return
	var anotherTeamId
	if teamId:
		anotherTeamId = 0
	else:
		anotherTeamId = 1
	if result:
		var addPoints
		var pointsAnim
		answers[teamId] = 2
		if answers[anotherTeamId] == 2:
			addPoints = 5
			pointsAnim = $Points5
		else:
			addPoints = 10
			pointsAnim = $Points10
		pointsAnim.position = c.position
		pointsAnim.visible = true
		pointsAnim.get_child(1).play("fly")
		pointsAnim.get_child(2).play()
		c.playRight()
		points[teamId] = points[teamId] + addPoints
	else:
		answers[teamId] = 1
		$AudioError.play()
		c.playError()
		points[teamId] = points[teamId] - 5
	updateScore()
	
func updateScore():
	$Score.setScore(points)
	
func _on_points5_animation_finished(anim_name):
	$Points5.hide()
