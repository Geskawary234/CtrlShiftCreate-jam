extends Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	cam_ready()
	await get_tree().create_timer(5,false).timeout
	$SpawnItemsArea.spawning = true

	
func cam_ready():
	$Camera3D.tracking_player = false
	await get_tree().create_timer(2,false).timeout
	$Camera3D.tracking_player = true

var game_time : float = 0
func _process(delta: float) -> void:
	if %Mouse.health>=0 and $SpawnItemsArea.spawning:
		game_time += delta
		Global.score = game_time
	
