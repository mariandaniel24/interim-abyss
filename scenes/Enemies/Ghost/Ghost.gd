extends Node2D
var player_found: Area2D

var health = 3
var is_alive = true
var is_awake = false

var min_wake_up_time = 0.3
var max_wake_up_time = 1

var speed = 100
var speed_multiplier = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	speed_multiplier = randf_range(1, 2)
	var wake_up_time = randf_range(min_wake_up_time, max_wake_up_time)
	await get_tree().create_timer(wake_up_time).timeout
	wake_up()

func wake_up():
	is_awake = true
	$AnimatedSprite2D.play("walk")
	player_found = get_node("/root/Game/Player") # Assuming the player_found node is named "Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if is_awake and is_alive and player_found:
		var direction = (player_found.global_position - global_position).normalized()
		global_position += direction * (speed * speed_multiplier) * delta


func apply_damage(amount: float):
	health -= amount
	if health <= 0:
		kill_entity()


func kill_entity():
	$CollisionShape2D.set_deferred("disabled", true)
	is_alive = false
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.flip_v = true
	await get_tree().create_timer(0.5).timeout
	queue_free()