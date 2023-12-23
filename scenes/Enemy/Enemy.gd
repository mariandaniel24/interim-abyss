extends Node2D

var min_wake_up_time = 0.3
var max_wake_up_time = 1
var speed = 100

var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(randf_range(min_wake_up_time, max_wake_up_time)).timeout
	wake_up()

func wake_up():
	$AnimatedSprite2D.play("walk")
	player = get_node("/root/Main/Player") # Assuming the player node is named "Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * speed * delta
