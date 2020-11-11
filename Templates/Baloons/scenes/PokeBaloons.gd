extends Node2D

export(String) var wantColor = "Red"

var baloon = preload("res://scenes/Baloon.tscn")

	
var textures = [
	preload("res://assets/img/fixed/baloon_pink.png"),
	preload("res://assets/img/fixed/baloon_red.png"),
	preload("res://assets/img/fixed/baloon_yellow.png"),
	preload("res://assets/img/fixed/baloon_orange.png"),
	preload("res://assets/img/fixed/baloon_blue.png"),
	preload("res://assets/img/fixed/baloon_white.png")
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
		var sz = Art.textures.size()-1
		baloons.append(String(rnd.randi_range(0, sz)))
		baloons.append(String(rnd.randi_range(0, sz)))
		baloons.append(String(rnd.randi_range(0, sz)))
		baloons.append(String(rnd.randi_range(0, sz)))
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
	b.art = Art.textures[type]
	b.stream = Art.audios[type]
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
