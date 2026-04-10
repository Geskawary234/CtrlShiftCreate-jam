extends Control

@onready var skip_progress: ProgressBar = $SkipProgress
@onready var hint: Label = $Label
@onready var hint_ap: AnimationPlayer = $Label/AnimationPlayer


func _ready() -> void:
	hint.modulate.a = 0
	skip_progress.value = 0

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		hint_ap.play('blink')

func _process(delta: float) -> void:
	var speed : float = delta * 70
	if Input.is_action_pressed('ui_accept'):
		skip_progress.value += speed
		
		if skip_progress.value>=100:
			get_tree().change_scene_to_file('res://Scenes/Game.tscn')
	else:
		skip_progress.value -= speed
		#get_tree().change_scene_to_file('res://Scenes/Game.tscn')
