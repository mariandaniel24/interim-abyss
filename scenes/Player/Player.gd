extends CharacterBody2D
signal player_hit

@export var speed: int = 800;

var screen_size: Vector2 = Vector2(0, 0);

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		player_hit.emit()
		Engine.time_scale = 0

	if velocity.x != 0:
		# $AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
