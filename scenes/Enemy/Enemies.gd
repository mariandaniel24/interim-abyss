extends Node
var Enemy = preload("res://scenes/Enemy/Enemy.tscn")

@export var player: CharacterBody2D 
@export var max_enemies = 10;
@export var min_spawn_range = 300;
@export var max_spawn_range = 1500;

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies()

func spawn_enemies():
	var current_enemies = get_children().size()
	var enemies_to_spawn = (max_enemies - current_enemies)

	for i in range(enemies_to_spawn):
		var enemy = Enemy.instantiate()
		var spawn_range = randf_range(min_spawn_range, max_spawn_range)
		# determine a random position within the spawn range
		var spawn_position = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * spawn_range + player.position
		enemy.position = spawn_position
		add_child(enemy)

	await get_tree().create_timer(5).timeout
	spawn_enemies()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
