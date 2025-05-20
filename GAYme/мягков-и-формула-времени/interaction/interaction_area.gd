extends Area2D
class_name Interaction_Area

#var action_name:String = "Взаимодействовать"

@export var action_name: String = "[e] для взаимодействовия"
@export var interaction_type: String = "default"  # "default", "math_puzzle", "dialog" и т.д.
@export var puzzle_scene: PackedScene  # Для математических примеров

var interaction: Callable = func():
	match interaction_type:
		"math_puzzle":
			open_math_puzzle()
		_:
			print("Базовое взаимодействие")

func open_math_puzzle():
	if puzzle_scene:
		var puzzle = puzzle_scene.instantiate()
		get_tree().current_scene.add_child(puzzle)
		puzzle.setup_puzzle()


#var interaction:Callable = func():
	#pass

func _on_body_entered(body: Node2D) -> void:
	Interaction_manager.register_area(self)

func _on_body_exited(body: Node2D) -> void:
	Interaction_manager.unregister_area(self)
