extends CanvasLayer

const START_LEVEL : String = "res://scenes/menu/menu.tscn"

@onready var menu = $pause/Menu
@onready var pause = $pause
@onready var options = $pause/Options_menu
@onready var audio = $pause/Audio
@onready var video = $pause/Video
@onready var Save = $pause/Menu/Save_Button
@onready var Load = $pause/Menu/Load_Button
@onready var button_back: Button = $pause/Options_menu/Back_Button

var is_paused : bool = false

func _ready() -> void:
	hide_pause_menu()
	Save.pressed.connect(_on_save_pressed)
	Load.pressed.connect(_on_load_pressed)
	pass

func show_and_hide(first, second):
	first.show()
	second.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	Save.grab_focus()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false


func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass


func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	await LevelMeneger.level_load_started
	hide_pause_menu()
	pass
	
#настройки
func _on_options_button_pressed() -> void:
	show_and_hide(options, menu)

#выход
func _on_exit_button_pressed() -> void:
	LevelMeneger.load_new_level(START_LEVEL, "", Vector2.ZERO)
	PlayerManager.player.visible = false
	#PausePanel.process_mode = Node.PROCESS_MODE_DISABLED
	Interaction_manager.visible = false
	Interaction_manager.enter_menu()
	self.queue_free()

#назад
func _on_back_button_pressed() -> void:
	show_and_hide(menu, options)
	button_back.grab_focus()
