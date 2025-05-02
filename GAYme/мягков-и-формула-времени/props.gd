extends StaticBody2D
@onready var area = $Interaction_Area

func _ready():
	area.interaction = Callable(self, "foo")

func foo():
	print("2  penns")
