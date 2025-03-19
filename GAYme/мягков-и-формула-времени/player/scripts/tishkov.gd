class_name Tishkov extends CharacterBody2D

var SPEED : float = 25000.0

func _ready() -> void:
	pass

func _process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * SPEED * delta
	
	pass

func _physics_process(delta):
	move_and_slide()
