extends Control



func _on_play_pressed() -> void:
	if Global.saw_comix:
		get_tree().change_scene_to_file('res://Scenes/Game.tscn')
	else:
		get_tree().change_scene_to_file('res://ui/comix.tscn')

func _on_exit_pressed() -> void:
	get_tree().quit()


func _ready() -> void:
	if randi_range(1,20)==1:
		$VideoStreamPlayer.stream = preload('res://Assets/video/spinning_mouse.ogv')
		$VideoStreamPlayer.play()
