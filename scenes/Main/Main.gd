extends Node
var enemy_scene = preload("res://scenes/Enemies/Ghost/Ghost.tscn")

@export var player: Area2D 
@export var max_enemies: int = 25;
@export var min_spawn_range: int = 300;
@export var max_spawn_range: int = 1500;

var can_spawn = true
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func spawn_enemies():
	if not can_spawn:
		return
	var current_enemies = get_children().size()
	var enemies_to_spawn = (max_enemies - current_enemies)

	for i in range(enemies_to_spawn):
		var enemy = enemy_scene.instantiate()
		var spawn_range = randf_range(min_spawn_range, max_spawn_range)
		# determine a random position within the spawn range
		var spawn_position = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * spawn_range + player.position
		enemy.position = spawn_position
		add_child(enemy)

	await get_tree().create_timer(5).timeout
	spawn_enemies()

func game_over():
	$ScoreTimer.stop()
	can_spawn = false
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("enemies", "queue_free")
	score = 0
	can_spawn = true
	spawn_enemies()

	$Player.start()
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$ScoreTimer.start()
