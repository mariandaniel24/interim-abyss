extends CanvasLayer
signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	$RestartButton.hide()
	$MainMenuButton.hide()


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$RestartButton.show()
	$MainMenuButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed():
	begin_start_game()


func begin_start_game():
	$RestartButton.hide()
	$MainMenuButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()


func _on_player_health_changed(health: float, health_max: float, is_initial: bool):
	$HealthBar.modify_health(health, health_max)
	# If this is the first time we're updating the health bar, don't play the animation.
	if not is_initial:
		$DamageOverlayAnimation.play("damage_screen")


func _on_restart_button_pressed():
	begin_start_game()


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Main/Main.tscn")

