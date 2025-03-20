extends Control

@onready var menu = $Menu
@onready var options = $Options_menu
@onready var audio = $Audio

#ПЕРЕХОД ГЛАВНОГО МЕНЮ 
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible

func _on_start_button_pressed() -> void:
	toggle()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_button_pressed() -> void:
	show_and_hide(options, menu)

func show_and_hide(first, second):
	first.show()
	second.hide()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	
func _on_back_button_pressed() -> void:
	show_and_hide(menu, options)
	
	
#НАСТРОЙКА МУЗЫКИ

func _on_master_value_changed(value: float) -> void:
	volume(0, value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)
	
func _on_music_value_changed(value: float) -> void:
	volume(1, value)

func _on_sound_fx_value_changed(value: float) -> void:
	volume(2, value)

func _on_back_option_button_pressed() -> void:
	show_and_hide(options, audio)

	
func _on_volume_button_pressed() -> void:
	show_and_hide(audio, options)


func _on_continue_button_pressed() -> void:
	toggle()
