extends Node2D

var is_alive = true
var min_wake_up_time = 0.3
var max_wake_up_time = 1
var speed = 100
var speed_multiplier = 1;

var player_found: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	speed_multiplier = randf_range(1, 2)
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(randf_range(min_wake_up_time, max_wake_up_time)).timeout
	wake_up()

func wake_up():
	$AnimatedSprite2D.play("walk")
	player_found = get_node("/root/Main/Player") # Assuming the player_found node is named "Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_alive and player_found:
		var direction = (player_found.global_position - global_position).normalized()
		global_position += direction * (speed * speed_multiplier) * delta

func kill_entity():
	$CollisionShape2D.set_deferred("disabled", true)
	is_alive = false
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.flip_v = true
	await get_tree().create_timer(0.5).timeout
	queue_free()