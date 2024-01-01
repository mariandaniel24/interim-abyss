extends Sprite2D

# I absolutely hate this, however this is one way to get the full health bar offset :)
const FULL_HEALTH_SIZE_X_VALUE: float = 526.6799926757812

func modify_health(health: float, health_max: float):
	$Value.size.x = (FULL_HEALTH_SIZE_X_VALUE * health) / health_max
