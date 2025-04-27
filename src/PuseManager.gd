extends Node

@onready var bg_music: AudioStreamPlayer = $Game/BgMusic

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('p') and %Mouse.health>0:
		get_tree().paused = !get_tree().paused
			
		if get_tree().paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$Game/Camera3D/Control.hide()
			$Game/Camera3D/PauseMenu.show()
			bg_music.pitch_scale = 0.5
			
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			$Game/Camera3D/Control.show()
			$Game/Camera3D/PauseMenu.hide()
			bg_music.pitch_scale = 1
