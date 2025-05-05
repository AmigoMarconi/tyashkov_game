extends Area2D
class_name Interaction_Area

var action_name:String = "blablabla"
var interaction:Callable = func():
	pass

func _on_body_entered(body: Node2D) -> void:
	Interaction_manager.register_area(self)

func _on_body_exited(body: Node2D) -> void:
	Interaction_manager.unregister_area(self)
