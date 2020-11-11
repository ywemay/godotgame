extends Node2D

export(String) var wantColor = "Red"

var baloon = preload("res://scenes/Buble.tscn")

var rnd = RandomNumberGenerator.new()
var baloons = []
var arts = Art.textures
var audios = Art.audios

func _ready():
	rnd.randomize()
	_instantiate_some_baloons()
	pass
	
func _instantiate_some_baloons():
	var tp
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
	for i in range(0, 20):
		tp = rnd.randi_range(0, baloons.size()-1)
		_instantiate_baloon(baloons[tp].to_int()) 
	pass

func _instantiate_baloon(type):
	var b = baloon.instance();
	
	if (rnd.randi_range(0, 3) == 0):
		b.art = arts[type]
		b.stream = audios[type]
	b.position = Vector2(rnd.randi_range(250, 1000), rnd.randi_range(100, 400));
	b.connect("pop", self, "_inst_baloon")
	$Baloons.add_child(b) 

func _inst_baloon():
	_instantiate_baloon(rnd.randi_range(0, baloons.size()-1))

func backToMenu():
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.stop()
		for ch in $Baloons.get_children():
			ch.queue_free()
	else:
		$AudioStreamPlayer.play()
		_instantiate_some_baloons()
