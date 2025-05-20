extends Button



func toggle():
	visible = !visible
	get_tree().paused = visible
	
func _on_start_button_pressed() -> void:
	toggle()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
