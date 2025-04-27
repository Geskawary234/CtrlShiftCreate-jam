extends Control


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(1,false).timeout
	
	var t = create_tween()
	
	t.tween_property($Label,'modulate',Color(1,1,1,1),1)
	
	await t.finished
	Global.saw_comix = true
	ready_for_next = true
	
var ready_for_next : bool = false
func _process(delta: float) -> void:
	if ready_for_next and Input.is_action_just_pressed('ui_accept'):
		get_tree().change_scene_to_file('res://Scenes/Game.tscn')
