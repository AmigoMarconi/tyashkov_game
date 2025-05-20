#extends CanvasLayer
#
#const START_LEVEL : String = "res://scenes/game.tscn"
#
#@export var music : AudioStream
#@export var button_focus_audio : AudioStream
#@export var button_press_audio : AudioStream
#
#@onready var menu: Control = $Menu
#@onready var options_menu: Control = $Options_menu
#@onready var audio_settings: Control = $Audio
#@onready var video_settings: Control = $Video
#@onready var button_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
#@onready var button_new: Button = $Menu/Start_Button
#@onready var button_continue: Button = $Menu/Continue_Button
#@onready var button_options: Button = $Menu/Options_Button
#@onready var button_exit: Button = $Menu/Exit_Button
#@onready var button_back: Button = $Options_menu/Back_Button
#
#
#func _ready() -> void:
	#
	#get_tree().paused = true
	#Interaction_manager.enter_menu()
#
	##print("Текущая камера: ", get_viewport().get_camera())
	#Interaction_manager.visible = false
	#PlayerManager.player.visible = false
	#PausePanel.process_mode = Node.PROCESS_MODE_DISABLED
#
##	Проверка наличия обновлений 
	#if SaveManager.get_save_file() == null:
		#button_continue.disabled = true
	#
	## Подключение сигналов
	#button_new.pressed.connect(start_game)
	#button_continue.pressed.connect(load_game)
	##button_back.pressed.connect(_on_back_button_pressed)
	#
	## Установка фокуса на кнопку "Новая игра"
	#button_new.grab_focus()
	#
	#button_new.focus_entered.connect(play_audio.bind(button_focus_audio))
	#button_continue.focus_entered.connect(play_audio.bind(button_focus_audio))
	#LevelMeneger.level_load_started.connect(exit_title_screen)
	## Аудио менеджер
  ##  AudioManager.play_music(music)
#
#func start_game() -> void:
	#play_audio(button_press_audio)
	#LevelMeneger.load_new_level(START_LEVEL, "", Vector2.ZERO)
	#
	#
#func load_game() -> void:
	#play_audio(button_press_audio)
	#SaveManager.load_game()  
#
#func show_and_hide(first, second):
	#first.show()
	#second.hide()
	#
#func exit_title_screen() -> void:
	#PlayerManager.player.visible = true
	#PausePanel.process_mode = Node.PROCESS_MODE_ALWAYS
	#Interaction_manager.visible = true
	#Interaction_manager.exit_menu()
	#self.queue_free()
#
## Обработчики кнопок меню
#func _on_options_button_pressed() -> void:
	#menu.hide()
	#options_menu.show()
	#button_back.grab_focus()
#
#func _on_back_button_pressed() -> void:
	#show_and_hide(menu, options_menu)
	#button_new.grab_focus()
#
#func _on_exit_button_pressed() -> void:
	#get_tree().quit()
#
## Настройки аудио (пример для мастер-громкости)
#func _on_master_value_changed(value: float) -> void:
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
#
#func play_audio(_a : AudioStream) -> void:
	#button_sound.stream = _a
	#button_sound.play()
	#
extends CanvasLayer

const START_LEVEL : String = "res://scenes/game.tscn"
@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_press_audio : AudioStream

@onready var menu: Control = $Menu
@onready var options_menu: Control = $Options_menu
@onready var audio_settings: Control = $Audio
@onready var video_settings: Control = $Video
@onready var button_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var button_new: Button = $Menu/Start_Button
@onready var button_continue: Button = $Menu/Continue_Button
@onready var button_options: Button = $Menu/Options_Button
@onready var button_exit: Button = $Menu/Exit_Button
@onready var button_back: Button = $Options_menu/Back_Button

@onready var fullscreen_toggle: CheckBox = %Fullscreen
@onready var borderless_toggle: CheckBox = %Borderless

func _ready() -> void:
	
	get_tree().paused = true
	Interaction_manager.enter_menu()
	Interaction_manager.visible = false
	PlayerManager.player.visible = false
	PausePanel.process_mode = Node.PROCESS_MODE_DISABLED
	
	# Инициализация настроек окна
	init_window_settings()
	
	# Проверка наличия сохранений
	if SaveManager.get_save_file() == null:
		button_continue.disabled = true
	
	# Подключение сигналов
	button_new.pressed.connect(start_game)
	button_continue.pressed.connect(load_game)
	
	# Установка фокуса на кнопку "Новая игра"
	button_new.grab_focus()
	
	button_new.focus_entered.connect(play_audio.bind(button_focus_audio))
	button_continue.focus_entered.connect(play_audio.bind(button_focus_audio))
	LevelMeneger.level_load_started.connect(exit_title_screen)
	
# Инициализация настроек окна
func init_window_settings():
	# Устанавливаем текущее состояние оконного режима
	var current_mode = DisplayServer.window_get_mode()
	fullscreen_toggle.button_pressed = (current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	# Устанавливаем текущее состояние рамок
	var is_borderless = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	borderless_toggle.button_pressed = is_borderless
	# Подключаем сигналы
	fullscreen_toggle.toggled.connect(_on_fullscreen_toggled)
	borderless_toggle.toggled.connect(_on_borderless_toggled)

# Функции управления окном
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		play_audio(button_press_audio)

func _on_borderless_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	play_audio(button_press_audio)

func start_game() -> void:
	play_audio(button_press_audio)
	
	# Сбрасываем флаги для новой игры
	PlayerManager.player_spawned = false
	LevelMeneger.is_first_load = true
	LevelMeneger.target_transition = ""
	
	print("MENU: Начинаем новую игру...")
	LevelMeneger.load_new_level(START_LEVEL, "", Vector2.ZERO)
	
func load_game() -> void:
	play_audio(button_press_audio)
	SaveManager.load_game()  

func show_and_hide(first, second):
	first.show()
	second.hide()
	
func exit_title_screen() -> void:
	PlayerManager.player.visible = true
	PausePanel.process_mode = Node.PROCESS_MODE_ALWAYS
	Interaction_manager.visible = true
	Interaction_manager.exit_menu()
	print("MENU: Выход из главного меню")
	self.queue_free()

# Обработчики кнопок меню
func _on_options_button_pressed() -> void:
	menu.hide()
	options_menu.show()
	button_back.grab_focus()

func _on_back_button_pressed() -> void:
	show_and_hide(menu, options_menu)
	

func _on_exit_button_pressed() -> void:
	get_tree().quit()

# Настройки аудио (пример для мастер-громкости)
func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func play_audio(_a : AudioStream) -> void:
	button_sound.stream = _a
	button_sound.play()

func _on_volume_button_pressed() -> void:
	show_and_hide(audio_settings, options_menu)

func _on_video_button_pressed() -> void:
	show_and_hide(video_settings, options_menu)

func _on_back_option_button_pressed() -> void:
	show_and_hide(options_menu, audio_settings)


func _on_back_video_button_pressed() -> void:
	show_and_hide(options_menu, video_settings)
