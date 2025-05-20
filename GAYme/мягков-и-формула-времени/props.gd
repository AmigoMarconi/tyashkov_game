#extends StaticBody2D
#@onready var area = $Interaction_Area
#
#func _ready():
	#area.interaction = Callable(self, "foo")
#
#func foo():
	#print("USING")

extends StaticBody2D

@onready var area = $Interaction_Area
@export var math_puzzle_scene: PackedScene  # Привяжите math_puzzle.tscn в инспекторе

func _ready():
	# Назначаем функцию взаимодействия
	area.interaction = Callable(self, "open_math_puzzle")
	
	# Настраиваем текст подсказки
	area.action_name = "Решить пример (E)"

func open_math_puzzle():
	if math_puzzle_scene:
		var puzzle = math_puzzle_scene.instantiate()
		get_tree().current_scene.add_child(puzzle)
		
		# Блокируем управление игроком
		#PlayerManager.set_player_controls(false)
		
		# Подключаем сигналы
		#puzzle.puzzle_solved.connect(_on_puzzle_solved)
		#puzzle.puzzle_closed.connect(_on_puzzle_closed)

func _on_puzzle_solved():
	#PlayerManager.set_player_controls(true)
	queue_free()  # Удаляем книгу после решения

#func _on_puzzle_closed():
	#PlayerManager.set_player_controls(true)
