extends Node2D

var Room = preload("res://scenes/Map/Room.tscn")

var tile_size = 128
var num_rooms = 50
var min_size = 4
var max_size = 10


func _ready():
	randomize()
	make_rooms()


func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(0, 0)
		var r = Room.instantiate()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)


func _process(_delta):
	queue_redraw()


func _input(event):
	if event.is_action_pressed("ui_select"):
		for r in $Rooms.get_children():
			r.queue_free()
		make_rooms()
