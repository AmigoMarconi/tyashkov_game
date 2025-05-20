#class_name Level extends Node2D
#
#
#func _ready() -> void:
	#self.y_sort_enabled = true
	#PlayerManager.set_as_parent(self)
	#LevelMeneger.level_load_started.connect(_free_level)
#
#
#func _free_level() -> void:
	#PlayerManager.unparent_player(self)
	#queue_free()
class_name Level extends Node2D

func _ready() -> void:
	# Включаем сортировку по Y для изометрического вида
	self.y_sort_enabled = true
	
	# Устанавливаем текущий уровень как родителя для игрока
	PlayerManager.set_as_parent(self)
	
	# Подписываемся на сигнал начала загрузки нового уровня
	LevelMeneger.level_load_started.connect(free_level)
	
	print("Level: Уровень инициализирован, игрок добавлен на сцену")

func free_level() -> void:
	# Отсоединяем игрока перед удалением уровня
	PlayerManager.unparent_player(self)
	print("Level: Уровень выгружается, игрок откреплен")
	queue_free()
