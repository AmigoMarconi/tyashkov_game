class_name LivelTileMap extends TileMap


func _ready() -> void:
	LevelMeneger.ChangeTileMapBounds(GetTileMapBounds())
	pass

func GetTileMapBounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)
	)
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size)
	)
	print("TileMap Bounds Updated: ", bounds)
	return bounds
