extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved


var current_save : Dictionary = {
	scene_path = "",
	player = {
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistense = [],
	quests = []
}

func save_game() ->void:
	update_player_data()
	update_scene_path()
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.WRITE)
	if file:
		var save_json = JSON.stringify(current_save)
		file.store_line(save_json)
		game_saved.emit()
		#print("gameSAVE")
	else: push_error("Failed to save game: ", FileAccess.get_open_error())

func load_game() -> void:
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.READ)
	if file:
		var json := JSON.new()
		var parse_result = json.parse(file.get_line())
		if parse_result == OK:
			var save_dict : Dictionary = json.get_data() as Dictionary
			current_save = save_dict
			LevelMeneger.load_new_level(current_save.scene_path, "", Vector2.ZERO)

			await LevelMeneger.level_load_started

			PlayerManager.set_player_position(Vector2(current_save.player.pos_x,current_save.player.pos_y))
	
			await LevelMeneger.level_loaded
	
			game_loaded.emit()
	
			#print("LOAD")
		else: push_error("Failed to parse save: ", json.get_error_message())
	else: push_error("Failed to load save: ", FileAccess.get_open_error())

func update_player_data() -> void:
	var p : Tishkov = PlayerManager.player
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y

func update_scene_path() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			p = c.scene_file_path
	current_save.scene_path = p
