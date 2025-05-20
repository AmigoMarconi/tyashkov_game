extends CanvasLayer
signal puzzle_solved
signal puzzle_closed
@onready var question_label = $Panel/Question
@onready var answer_input = $Panel/InputLine
var correct_answer: int = 0

#func _ready():
	# Вызываем setup_puzzle() при создании сцены
	#setup_puzzle()

func setup_puzzle():
	# Генерируем случайный пример
	var a = 8
	var b = 9
	correct_answer = a * b  # Исправление: правильный ответ должен быть равен a + b (17)
	
	# Отладочное сообщение
	print("Задача: ", a, " + ", b, " = ", correct_answer)
	
	# Устанавливаем текст вопроса
	
	answer_input.text = ""  # Очищаем поле ввода
	answer_input.grab_focus()
	show()

func _on_submit_pressed():
	print("Введенный ответ: ", answer_input.text)
	print("Ожидаемый ответ: ", correct_answer)
	print("is_valid_int(): ", answer_input.text.is_valid_int())
	
	if answer_input.text.is_valid_int():
		var user_answer = answer_input.text.to_int()
		print("Преобразованный ответ: ", user_answer)
		print("Сравнение: ", user_answer, " == ", correct_answer, " => ", user_answer == correct_answer)
		
		if user_answer == correct_answer:
			print("Ответ верный! Эмиттинг сигнала puzzle_solved")
			puzzle_solved.emit()
			queue_free()
		else:
			print("Ответ неверный")
			answer_input.text = ""
			answer_input.placeholder_text = "Неверно! Попробуйте снова"
	else:
		print("Введён не целочисленный ответ")
		answer_input.text = ""
		answer_input.placeholder_text = "Введите числовой ответ"

func _on_close_pressed():
	emit_signal("puzzle_closed")
	queue_free()
