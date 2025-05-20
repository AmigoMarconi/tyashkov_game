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
		PlayerManager.set_controls_enabled(false)
		
		# Подключаем сигналы
		puzzle.puzzle_solved.connect(_on_puzzle_solved)
		puzzle.puzzle_closed.connect(_on_puzzle_closed)
		
		# Вызываем setup_puzzle, если он не вызывается автоматически
		if puzzle.has_method("setup_puzzle"):
			puzzle.setup_puzzle()

func _on_puzzle_solved():
	# Разрешаем управление игроком
	PlayerManager.set_controls_enabled(true)
	
	print("Головоломка решена! Удаляем книгу...")
	queue_free()  # Удаляем книгу после решения головоломки

func _on_puzzle_closed():
	# Разрешаем управление игроком
	PlayerManager.set_controls_enabled(true)
	
	print("Головоломка закрыта без решения")
