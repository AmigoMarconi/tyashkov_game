#extends Node2D
#
#
#func _ready() -> void:
	#visible = false
	#await get_tree().process_frame
	#if PlayerManager.player_spawned == false:
		#PlayerManager.set_player_position(global_position)
		#PlayerManager.player_spawned = true
extends Node2D

func _ready() -> void:
	visible = false
	add_to_group("player_spawn")
	
	# Подождем один кадр для уверенности, что все готово
	await get_tree().process_frame
	
	# Устанавливаем позицию только при первом запуске и если нет активного перехода
	if LevelMeneger.is_first_load && LevelMeneger.target_transition == "":
		PlayerManager.set_player_position(global_position)
		print("PLAYERSPAWN: Установлена начальная позиция игрока: ", global_position)
		PlayerManager.player_spawned = true
