extends CanvasLayer

signal puzzle_solved
signal puzzle_closed

@onready var question_label = $Panel/Question
@onready var answer_input = $Panel/InputLine

var correct_answer: int

func setup_puzzle():
	# Генерируем случайный пример
	var a = 8
	var b = 9
	correct_answer = 12
	answer_input.grab_focus()
	show()

func _on_submit_pressed():
	if answer_input.text.is_valid_int() and answer_input.text.to_int() == correct_answer:
		puzzle_solved.emit()
		queue_free()
	else:
		answer_input.text = ""
		answer_input.placeholder_text = "Неверно! Попробуйте снова"

func _on_close_pressed():
	emit_signal("puzzle_closed")
	queue_free()
