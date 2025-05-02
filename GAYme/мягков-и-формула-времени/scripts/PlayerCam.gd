class_name PlayerCam extends Camera2D


func _ready():
	LevelMeneger.TileMapBoundsChanged.connect(UpdateLimits)
	UpdateLimits(LevelMeneger.current_tilemap_bounds)
	make_current()
	pass

func UpdateLimits( bounds : Array[ Vector2 ]) -> void:
	if bounds == []:
		return
	limit_top = int(bounds[0].y )
	limit_left = int(bounds[0].x)
	limit_bottom = int(bounds[1].y)
	limit_right = int( bounds[1].x)
	print("Camera Limits: ", bounds)
	pass
