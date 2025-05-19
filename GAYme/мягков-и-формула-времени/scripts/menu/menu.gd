extends Control

@onready var menu = $Menu
@onready var options = $Options_menu
@onready var audio = $Audio
@onready var video = $Video

#МЕНЮ ПАУЗЫ
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible
	
	
#ПЕРЕХОД ГЛАВНОГО МЕНЮ 
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

func _on_video_button_pressed() -> void:
	show_and_hide(video, options)
	
func _on_back_video_button_pressed() -> void:
	show_and_hide(options, video)

func _on_back_option_button_pressed() -> void:
	show_and_hide(options, audio)

	
func _on_volume_button_pressed() -> void:
	show_and_hide(audio, options)


func _on_continue_button_pressed() -> void:
	toggle()
	

#НАСТРОЙКА ВИДЕО

func _ready():
	#СЕЙВ ВИДЕО
	var screen_type = Persistence.config.get_value("Video", "Fullscreen")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%Fullscreen.button_pressed = true
	
	var borderless_type = Persistence.config.get_value("Video", "Borderless")
	if borderless_type:
		%Borderless.button_pressed = true
		
	var vsync_index = Persistence.config.get_value("Video", "Vsync", 0)
	%Vsync.selected = vsync_index
	
	#СЕЙВ ЗВУКА
	%Master.value = Persistence.config.get_value("Audiio", '0')
	AudioServer.set_bus_volume_db(0, linear_to_db(%Master.value))
	
	%Music.value = Persistence.config.get_value("Audio", '1')
	AudioServer.set_bus_volume_db(1, linear_to_db(%Music.value))
	
	%SoundFX.value = Persistence.config.get_value("Audio", '2')
	AudioServer.set_bus_volume_db(0, linear_to_db(%SoundFX.value))
	
	
func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video", "fulscreen", DisplayServer.WINDOW_MODE_WINDOWED)
		
	Persistence.save_data()
	
func _on_borderless_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	Persistence.config.set_value("Video", "bordless", toggled_on)
	Persistence.save_data()

func _on_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	Persistence.config.set_value("Video", "vsync", index)
	Persistence.save_data()

	
#НАСТРОЙКА МУЗЫКИ

func _on_master_value_changed(value: float) -> void:
	volume(0, value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)
	
func _on_music_value_changed(value: float) -> void:
	volume(1, value)

func _on_sound_fx_value_changed(value: float) -> void:
	volume(2, value)

func set_volume(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value) )
	Persistence.config.set_value("Audio", str(idx), value)
	Persistence.save_data()
