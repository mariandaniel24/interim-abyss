extends Sprite2D

const FULL_HEALTH_SIZE_X_VALUE: float = 526.679992675781

# Called when the node enters the scene tree for the first time.
func _ready():
	# set the health bar to zero
	$Value.set_size(Vector2(0, $Value.get_size().y))
	
func modify_health(health: float, health_max: float):
	$Value.set_size(Vector2(FULL_HEALTH_SIZE_X_VALUE * health / health_max, $Value.get_size().y))
