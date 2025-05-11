extends ParallaxBackground

@export var speed = 20
var accumulated_offset = 0.0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if has_node("/root/Interaction_manager"):
		get_node("/root/Interaction_manager").visible = false
	if has_node("/root/PlayerManager"):
		get_node("/root/PlayerManager").player.visible = false
	if has_node("/root/PausePanel"):
		get_node("/root/PausePanel").process_mode = Node.PROCESS_MODE_DISABLED
	if Engine.has_singleton("PlayerManager"):
		var player = Engine.get_singleton("PlayerManager").player
		if is_instance_valid(player):
			player.visible = false

func _process(delta):
	accumulated_offset += speed * delta
	scroll_base_offset.x = -accumulated_offset
