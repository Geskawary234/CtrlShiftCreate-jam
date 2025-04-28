extends Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Global.did_tutorial:
		$Convoyer.speed = 2.5
		await get_tree().create_timer(5,false).timeout
		$SpawnItemsArea.spawning = true
	cam_ready()
		
	#await get_tree().create_timer(5,false).timeout
	#$SpawnItemsArea.spawning = true
func start_game():
	var t = create_tween()
	t.tween_property($Convoyer,'speed',2.5,3)
	await get_tree().create_timer(5,false).timeout
	$SpawnItemsArea.spawning = true

@onready var cam: Camera3D = $CamPivot/Camera3D
func cam_ready():
	cam.tracking_player = false
	await get_tree().create_timer(2,false).timeout
	cam.tracking_player = true

var game_time : float = 0
func _process(delta: float) -> void:
	if %Mouse.health>=0 and $SpawnItemsArea.spawning:
		game_time += delta
		Global.score = game_time
	
