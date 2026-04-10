extends Control

@onready var label: Label = $Label
@onready var box_cont: VBoxContainer = $VBoxContainer
@onready var died_overlay: Sprite2D = $DiedOverlay



func _ready() -> void:
	label.modulate.a = 0
	box_cont.modulate.a = 0
	
	died_overlay.show()
	await get_tree().create_timer(0.1,false).timeout
	var t2 : = create_tween()
	await t2.tween_property(died_overlay,'frame',4,0.4).finished
	
	
	
	label.text = 'You died!\nScore: '+str(Global.score)
	var t = create_tween()
	t.parallel().tween_property(label,'modulate',Color(1,1,1,1),1)
	t.parallel().tween_property(box_cont,'modulate',Color(1,1,1,1),1)

func _on_retry_pressed() -> void:
	Global.score = 0
	get_tree().change_scene_to_file('res://Scenes/Game.tscn')


func _on_exit_pressed() -> void:
	Global.score = 0
	get_tree().change_scene_to_file('res://ui/Mainmenu.tscn')
