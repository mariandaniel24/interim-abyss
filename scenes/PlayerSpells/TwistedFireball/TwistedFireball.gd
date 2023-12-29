extends Area2D
signal enemy_hit

@export var speed: float = 200.0
var distance_from_parent: float = 0.0
var degress: float = randf_range(0.0, 360.0)


# Called when the node enters the scene tree for the first time.
func _ready():
	distance_from_parent = position.length()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	rotate_fireball(delta)

# rotate the sprite around the center of the parent node
func rotate_fireball(delta: float):
	rotation_degrees += delta * speed
	position.y = sin(rotation_degrees / 180.0 * PI) * distance_from_parent
	position.x = cos(rotation_degrees / 180.0 * PI) * distance_from_parent

func _on_body_entered(body: Node2D):
	print(body)
	body.kill_entity()
