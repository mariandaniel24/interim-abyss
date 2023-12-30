extends Area2D
signal health_changed
signal death




@export var speed: int = 600
@export var max_health = 5
var health = max_health 
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


# Called when the player is hit by an enemy.
func _on_body_entered(body: Node2D):
	if body.is_in_group("enemies") or body.is_in_group("enemy_attacks"):
		health -= 1
		health_changed.emit(health, max_health, false)
		if health <= 0:
			kill_player()


func kill_player():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	death.emit()


func start():
	show()
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	$CollisionShape2D.disabled = false
	health = max_health
	health_changed.emit(health, max_health, true) # emitting the signal to update the health bar

