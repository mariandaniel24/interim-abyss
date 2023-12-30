extends Area2D
signal enemy_hit

@export var speed: float = 200.0
var degress: float = randf_range(0.0, 360.0)
var current_damage: float = 1.0

@export var line2d: Line2D

@onready var audio = $AudioStreamPlayer2D
@onready var sound_attack_1 = preload("res://scenes/PlayerSpells/TwistedFireball/attack1.wav")
@onready var sound_attack_2 = preload("res://scenes/PlayerSpells/TwistedFireball/attack2.wav")
@onready var sound_attack_3 = preload("res://scenes/PlayerSpells/TwistedFireball/attack3.wav")
@onready var attack_sounds = [sound_attack_1, sound_attack_2, sound_attack_3]
@onready var distance_from_parent: float = position.length()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	rotate_fireball(delta)	

# rotate the sprite around the center of the parent node
func rotate_fireball(delta: float):
	rotation_degrees += delta * speed
	position.y = sin(rotation_degrees / 180.0 * PI) * distance_from_parent
	position.x = cos(rotation_degrees / 180.0 * PI) * distance_from_parent

	# line2d should offset the rotation of the parent node	

func _on_body_entered(body: Node2D):
	if body.is_in_group("enemies"):
		audio.stream = attack_sounds[randi() % attack_sounds.size()]
		audio.play()
		body.apply_damage(current_damage)
