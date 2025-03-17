extends AudioStreamPlayer2D

func _ready() -> void:
	stream = load("res://sounds/Битва за сортир.mp3")
	play()
