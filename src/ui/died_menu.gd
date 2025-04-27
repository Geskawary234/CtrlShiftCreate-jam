extends Control


func _ready() -> void:
	
	$Label.text = 'You died!\nScore: '+str(Global.score)
	var t = create_tween()
	t.parallel().tween_property($Label,'modulate',Color(1,1,1,1),1)
	t.parallel().tween_property($Retry,'modulate',Color(1,1,1,1),1)

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Game.tscn')
