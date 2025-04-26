extends Item

@export var sounds : AudioStream
var player : AudioStreamPlayer3D

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	
	player = AudioStreamPlayer3D.new()
	add_child(player)
	player.stream = sounds
	
	body_entered.connect(play_effect)
	
func play_effect(b):
	if !player.is_playing():
		player.play()
		
