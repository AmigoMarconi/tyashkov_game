extends AudioStreamPlayer2D

@onready var volume_slider = $"../Audio/HBoxContainer/MusicVolumeSlider"
const SOUND_PATH = "res://sounds/Untitled.mp3"
	
func _ready():
	stream = load(SOUND_PATH)
	play()
	
