extends Node2D

export(String) var wantColor = "Red"

var baloon = preload("res://scenes/Baloon.tscn")

var sounds = [
	preload("res://assets/audio/bag.wav"),
	preload("res://assets/audio/bags.wav"),
	preload("res://assets/audio/book.wav"),
	preload("res://assets/audio/books.wav"),
	preload("res://assets/audio/crayon.wav"),
	preload("res://assets/audio/crayons.wav"),
	preload("res://assets/audio/pencil.wav"),
	preload("res://assets/audio/pencils.wav"),
	preload("res://assets/audio/rubber.wav"),
	preload("res://assets/audio/rubbers.wav"),
	preload("res://assets/audio/teacher.wav"),
	]
	
var textures = [
	preload("res://assets/baloon_pink.png"),
	preload("res://assets/baloon_red.png"),
	preload("res://assets/baloon_yellow.png"),
	preload("res://assets/baloon_orange.png"),
	preload("res://assets/baloon_blue.png"),
	preload("res://assets/baloon_white.png")
	]

var arts = [
	preload("res://assets/art/bag.png"),
	preload("res://assets/art/bags.png"),
	preload("res://assets/art/book.png"),
	preload("res://assets/art/books.png"),
	preload("res://assets/art/crayon.png"),
	preload("res://assets/art/crayons.png"),
	preload("res://assets/art/pencil.png"),
	preload("res://assets/art/pencils.png"),
	preload("res://assets/art/rubber.png"),
	preload("res://assets/art/rubbers.png"),
	preload("res://assets/art/teacher.png"),
	]

var rnd = RandomNumberGenerator.new()
var baloons = []
var bcolor = 0
"res://assets/art/pencil.png"
func _ready():
	rnd.randomize()
	_instantiate_some_baloons()
	pass
	
func _instantiate_some_baloons():
	bcolor = rnd.randi_range(0, 5)
	var tp
	var correct
	baloons = JavaScript.eval("baloons")
	if !baloons:
		# baloons = [ '0', '1', '2', '3' ]
		baloons = []
		baloons.append(String(rnd.randi_range(0, arts.size()-1)))
		baloons.append(String(rnd.randi_range(0, arts.size()-1)))
		baloons.append(String(rnd.randi_range(0, arts.size()-1)))
		baloons.append(String(rnd.randi_range(0, arts.size()-1)))
	else:
		baloons = baloons.split('+')
	for i in range(0, 40):
		tp = rnd.randi_range(0, baloons.size()-1)
		if tp == 0:
			correct = true	
		else:
			correct = false
		_instantiate_baloon(baloons[tp].to_int()) 
	pass

func _instantiate_baloon(type):
	var b = baloon.instance();
	b.texture = textures[bcolor]
	b.art = arts[type]
	b.stream = sounds[type]
	b.position = Vector2(rnd.randi_range(250, 1000), 0);
	# b.connect("pop", self, _instantiate_baloon(rnd.randi_range(0, baloons.size()-1)))
	$Baloons.add_child(b) 

func backToMenu():
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.stop()
		for ch in $Baloons.get_children():
			ch.queue_free()
	else:
		$AudioStreamPlayer.play()
		_instantiate_some_baloons()
