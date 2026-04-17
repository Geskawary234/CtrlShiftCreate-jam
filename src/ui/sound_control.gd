extends VBoxContainer

@onready var sound_lower: Button = $Sound/sound_lower
@onready var sound_higher: Button = $Sound/sound_higher
@onready var sound_lab: Label = $Sound/Label

@onready var music_lower: Button = $Music/music_lower
@onready var music_higher: Button = $Music/music_higher
@onready var music_lab: Label = $Music/Label

var sound_bus : int = 2
var music_bus : int = 1

func _ready() -> void:
	music_lab.text = 'Music: '+str(int(AudioServer.get_bus_volume_db(music_bus)))
	sound_lab.text = 'Sound: '+str(int(AudioServer.get_bus_volume_db(sound_bus)))
	
	sound_higher.pressed.connect(func(): change_bus_volume(1,sound_bus))
	sound_lower.pressed.connect(func(): change_bus_volume(-1,sound_bus))
	
	music_higher.pressed.connect(func(): change_bus_volume(1,music_bus))
	music_lower.pressed.connect(func(): change_bus_volume(-1,music_bus))
	


func change_bus_volume(v : float,bus : int):
	var volume : float = AudioServer.get_bus_volume_db(bus)
	AudioServer.set_bus_volume_db(bus,volume + v)
	
	music_lab.text = 'Music: '+str(int(AudioServer.get_bus_volume_db(music_bus)))
	sound_lab.text = 'Sound: '+str(int(AudioServer.get_bus_volume_db(sound_bus)))
	
	
	
