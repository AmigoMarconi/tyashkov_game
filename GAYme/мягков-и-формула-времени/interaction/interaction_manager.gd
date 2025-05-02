extends Node2D

@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var label = $Use_text
var Areas:Array[Interaction_Area] = []

func register_area(area:Interaction_Area):
	Areas.push_back(area)

func unregister_area(area:Interaction_Area):
	var index = Areas.find(area)
	if index != -1:
		Areas.remove_at(index)

func _sort_by_distance_to_player(a:Interaction_Area, b:Interaction_Area) -> bool:
	var dist1 = player.global_position.distance_to(a.global_position)
	var dist2 = player.global_position.distance_to(b.global_position)
	return dist1 < dist2

func _process(delta: float) -> void:
	if Areas.size() > 0:
		Areas.sort_custom(_sort_by_distance_to_player)
		label.global_position = Areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _input(event:InputEvent):
	if Areas.size() > 0 and event.is_action_pressed("Use"):
		Areas[0].interaction.call()
