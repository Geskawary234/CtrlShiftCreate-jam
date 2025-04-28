extends ItemSound
class_name HeavyItem

var shock_camera : bool = false
func play_effect(other):
	super.play_effect(other)
	
	if !shock_camera:
		mouse.cam.shake_duration = 0.5
		mouse.cam.shake()
		shock_camera = true
