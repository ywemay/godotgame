extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pullBar = preload("res://PullBar.tscn")
var card = preload("res://Card.tscn")
var pullSize = 0
var expectId = -1
var cananswer = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pullSize = Art.textures.size()
	var h = get_viewport_rect().end.y
	var w = get_viewport_rect().end.x
	var padding = 60
	var spacing = (h - padding * 2) / pullSize
	if spacing > 100:
		spacing = 100
	var o
	var colors = [
		"45603b",
		"55603b",
		"65603b",
		"85603b",
		"95603b",
		"95703b",
		"95803b",
		"95804b",
		"95805b",
	]
	var clr
	var c
	for i in range(0, pullSize):
		o = pullBar.instance()
		clr = colors[i%colors.size()]
		o.color = clr
		o.objId = i
		o.connect("click", self, "_click")
		o.position = Vector2(w/2 - 250-5, h - i * spacing - padding)
		$Team1.add_child(o)
		o = pullBar.instance()
		o.color = clr
		o.objId = i
		o.connect("click", self, "_click")
		o.position = Vector2(w/2 + 5 + 250, h - i * spacing - padding)
		$Team2.add_child(o)
		c = card.instance()
		c.texture = Art.textures[i]
		c.position = Vector2(w/2, h - i * spacing - padding)
		$Cards.add_child(c)
	init_game()

func init_game():
	$Timer.start()

func _click(o):
	if !cananswer:
		return
	cananswer = false
	var direction
	if o.get_parent().name == 'Team1':
		direction = -1
	else:
		direction = 1
	if expectId != o.objId:
		direction = -direction
		$AudioError.play()
	else:
		$AudioCharm.play()
	$Cards.get_child(o.objId).position.x += direction * 50 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	expectId = randi() % pullSize
	cananswer = true
	$AudioWord.stream = Art.audios[expectId]
	$AudioWord.play()
