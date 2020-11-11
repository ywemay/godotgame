extends Node

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

func file_exists(fname):
	var f = File.new();
	return f.file_exists(fname)

func dir_exists(fname):
	var d = Directory.new();
	return d.file_exists(fname)

func merge(a, b):
	var rez = []
	for i in a:
		rez.append(i)
	for i in b:
		rez.append(i)
	return rez
