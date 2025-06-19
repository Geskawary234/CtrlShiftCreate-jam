extends ItemSound
class_name HeavyItem

func _ready() -> void:
	super._ready()
	max_damage = 25

var shock_camera : bool = false
func play_effect(other):
	super.play_effect(other)
	
	if !shock_camera:
		if is_instance_valid(mouse):
			mouse.cam.shake_duration = 0.5
			mouse.cam.shake()
		shock_camera = true
