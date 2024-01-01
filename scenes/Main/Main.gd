extends Node
var enemy_scene = preload("res://scenes/Enemies/Ghost/Ghost.tscn")

@onready var MainCategoryNode = get_node("Main")
@onready var SettingsCategoryNode = get_node("Settings")

@onready var SettingsMasterVolumeSliderNode = get_node("Settings").get_node("MasterVolumeSlider")


func _ready():
	# set the initial master volume slider value
	set_initial_master_volume_slider_value()

func _on_settings_button_pressed():
	MainCategoryNode.hide()
	SettingsCategoryNode.show()

func _on_exit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Game/Game.tscn")

func _on_settings_back_button_pressed():
	SettingsCategoryNode.hide()
	MainCategoryNode.show()
	
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
