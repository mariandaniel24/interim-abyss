extends CanvasLayer
signal start_game

@onready var RestartButtonNode = get_node("Game").get_node("RestartButton")
@onready var MainMenuButtonNode = get_node("Game").get_node("MainMenuButton")
@onready var HealthBarNode = get_node("Game").get_node("HealthBar")
@onready var ScoreLabelNode = get_node("Game").get_node("ScoreLabel")
@onready var MessageNode = get_node("Game").get_node("Message")
@onready var MessageTimerNode = get_node("Game").get_node("MessageTimer")
@onready var DamageOverlayAnimationNode = get_node("Game").get_node("DamageOverlayAnimation")

@onready var GameCategoryNode = get_node("Game")
@onready var MainCategoryNode = get_node("Main")
@onready var SettingsCategoryNode = get_node("Settings")


@onready var SettingsMasterVolumeSliderNode = get_node("Settings").get_node("MasterVolumeSlider")

# Called when the node enters the scene tree for the first time.
func _ready():
	MainCategoryNode.show()
	set_initial_master_volume_slider_value()

func show_message(text):
	MessageNode.text = text
	MessageNode.show()
	MessageTimerNode.start()



func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await MessageTimerNode.timeout

	MessageNode.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	RestartButtonNode.show()
	MainMenuButtonNode.show()


func update_score(score):
	ScoreLabelNode.text = str(score)


func _on_start_button_pressed():
	begin_start_game()

func begin_start_game():
	GameCategoryNode.show() # begin by showing the game node in the HUD
	SettingsCategoryNode.hide()
	MainCategoryNode.hide()
	RestartButtonNode.hide()
	MainMenuButtonNode.hide()
	MainCategoryNode.hide()
	start_game.emit()

func _on_message_timer_timeout():
	MessageNode.hide()

func _on_player_health_changed(health: float, health_max: float, is_initial: bool):
	HealthBarNode.modify_health(health, health_max)
	# If this is the first time we're updating the health bar, don't play the animation.
	if not is_initial:
		DamageOverlayAnimationNode.play("damage_screen")

func _on_settings_button_pressed():
	SettingsCategoryNode.show()
	MainCategoryNode.hide()

func _on_exit_button_pressed():
	get_tree().quit()

func _on_restart_button_pressed():
	begin_start_game()


func _on_main_menu_button_pressed():
	MainCategoryNode.show()
	GameCategoryNode.hide()


# Settings
func set_initial_master_volume_slider_value():
	var master_idx = AudioServer.get_bus_index("Master")
	var master_volume_db = AudioServer.get_bus_volume_db(master_idx)
	var master_volume_percent = (master_volume_db + 60) / 60 * 100
	SettingsMasterVolumeSliderNode.value = master_volume_percent

func _on_master_volume_slider_value_changed(value: float):
	var master_idx = AudioServer.get_bus_index("Master")
	var new_volume = (value / 100) * 60 - 60
	AudioServer.set_bus_volume_db(master_idx, new_volume)


