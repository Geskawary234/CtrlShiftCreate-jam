extends Node

@onready var bg_music: AudioStreamPlayer = $Game/BgMusic

@onready var control: Control = $Game/CamPivot/Camera3D/Control
@onready var pause_menu: Control = $Game/CamPivot/Camera3D/PauseMenu
@onready var tutorial: Control = $Game/CamPivot/Camera3D/Tutorial


func _process(delta: float) -> void:
	if Input.is_action_just_pressed('esc') and %Mouse.health>0:
		get_tree().paused = !get_tree().paused
			
		if get_tree().paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			control.hide()
			tutorial.hide()
			pause_menu.show()
			%Mouse.cam.set_blur(true)
			bg_music.pitch_scale = 0.5
			
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			control.show()
			if !Global.did_tutorial: tutorial.show()
			pause_menu.hide()
			%Mouse.cam.set_blur(false)
			bg_music.pitch_scale = 1
