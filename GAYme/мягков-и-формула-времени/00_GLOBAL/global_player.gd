#extends Node
#
#const PLAYER = preload("res://player/tishkov.tscn")
#
#
#var player : Tishkov
#var player_spawned : bool = false
#
#func _ready() -> void:
	#add_player_instance()
	#await get_tree().create_timer(0.5).timeout
	#player_spawned = true
#
#
#func add_player_instance() -> void:
	#player = PLAYER.instantiate()
	#add_child(player)
	#pass
#
#func set_player_position(_new_pos : Vector2) -> void:
	#player.global_position = _new_pos
	#pass
#
#func set_as_parent(_p : Node2D) -> void:
	#if player.get_parent():
		#player.get_parent().remove_child(player)
	#_p.add_child(player)
#
#func unparent_player(_p:Node2D) -> void:
	#_p.remove_child(player)
#
#func set_controls_enabled(enabled: bool):
	#set_process_input(enabled)
	#set_process_unhandled_input(enabled)

#extends Node
#
#const PLAYER = preload("res://player/tishkov.tscn")
#var player : Tishkov
#var player_spawned : bool = false
#
#func _ready() -> void:
	#add_player_instance()
	#
	## Подписываемся на сигнал загрузки уровня
	#LevelMeneger.level_loaded.connect(_on_level_loaded)
#
#func add_player_instance() -> void:
	#if !player:
		#player = PLAYER.instantiate()
		#add_child(player)
		#print("PlayerManager: Игрок создан")
#
#func _on_level_loaded() -> void:
	#print("PlayerManager: Уровень загружен")
	#
	## Если это переход через LevelPerehod, то позиция будет установлена 
	## в методе place_player скрипта LevelPerehod
	#if LevelMeneger.target_transition != "":
		#print("PlayerManager: Ожидание установки позиции через LevelPerehod")
		#return
		#
	## Если это начальный запуск или новая игра
	#if !player_spawned || LevelMeneger.is_first_load:
		#var spawn_points = get_tree().get_nodes_in_group("player_spawn")
		#if spawn_points.size() > 0:
			#set_player_position(spawn_points[0].global_position)
			#print("PlayerManager: Установлена позиция через точку спавна: ", spawn_points[0].global_position)
		#else:
			#print("PlayerManager: ВНИМАНИЕ! Точка спавна не найдена!")
			#set_player_position(Vector2(100, 100)) # Запасная позиция
	#
	#player_spawned = true
#
#func set_player_position(new_pos : Vector2) -> void:
	#if player:
		#player.global_position = new_pos
		#print("PlayerManager: Позиция игрока установлена на ", new_pos)
#
#func set_as_parent(p : Node2D) -> void:
	#if player and player.get_parent():
		#player.get_parent().remove_child(player)
	#if p:
		#p.add_child(player)
		#print("PlayerManager: Игрок прикреплен к ", p.name)
#
#func unparent_player(p : Node2D) -> void:
	#if p and player and player.get_parent() == p:
		#p.remove_child(player)
		#print("PlayerManager: Игрок откреплен от ", p.name)
#
#func set_controls_enabled(enabled: bool):
	#if player:
		#player.set_process_input(enabled)
		#player.set_process_unhandled_input(enabled)

extends Node
const PLAYER = preload("res://player/tishkov.tscn")
var player : Tishkov
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance()
	
	# Подписываемся на сигнал загрузки уровня
	LevelMeneger.level_loaded.connect(_on_level_loaded)

func add_player_instance() -> void:
	if !player:
		player = PLAYER.instantiate()
		add_child(player)
		print("PlayerManager: Игрок создан")

func _on_level_loaded() -> void:
	print("PlayerManager: Уровень загружен")
	
	# Если это переход через LevelPerehod, то позиция будет установлена 
	# в методе place_player скрипта LevelPerehod
	if LevelMeneger.target_transition != "":
		print("PlayerManager: Ожидание установки позиции через LevelPerehod")
		return
		
	# Если это начальный запуск или новая игра
	if !player_spawned || LevelMeneger.is_first_load:
		var spawn_points = get_tree().get_nodes_in_group("player_spawn")
		if spawn_points.size() > 0:
			set_player_position(spawn_points[0].global_position)
			print("PlayerManager: Установлена позиция через точку спавна: ", spawn_points[0].global_position)
		else:
			print("PlayerManager: ВНИМАНИЕ! Точка спавна не найдена!")
			set_player_position(Vector2(100, 100)) # Запасная позиция
	
	player_spawned = true

func set_player_position(new_pos : Vector2) -> void:
	if player:
		player.global_position = new_pos
		print("PlayerManager: Позиция игрока установлена на ", new_pos)

func set_as_parent(p : Node2D) -> void:
	if player and player.get_parent():
		player.get_parent().remove_child(player)
	if p:
		p.add_child(player)
		print("PlayerManager: Игрок прикреплен к ", p.name)

func unparent_player(p : Node2D) -> void:
	if p and player and player.get_parent() == p:
		p.remove_child(player)
		print("PlayerManager: Игрок откреплен от ", p.name)

func set_controls_enabled(enabled: bool):
	if player:
		# Блокируем или разблокируем движение игрока
		player.set_process_input(enabled)
		player.set_process_unhandled_input(enabled)
		player.set_physics_process(enabled)  # Блокируем физический процесс (движение)
		
		# Если нужно также заблокировать анимацию
		if player.has_node("AnimationPlayer"):
			var anim_player = player.get_node("AnimationPlayer")
			if !enabled and anim_player.is_playing():
				anim_player.stop()
