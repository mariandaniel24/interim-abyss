extends Area2D
signal player_hit
@export var speed: int = 600
var screen_size = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not visible:
		return
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	position += velocity * delta
	# position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(_body: Node2D):
	hide()
	player_hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start():
	show()
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	$CollisionShape2D.disabled = false
