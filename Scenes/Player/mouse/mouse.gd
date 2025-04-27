extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 4.5

@onready var cam: Camera3D = $"../Camera3D"
@onready var physical_col: RigidBody3D = $RigidBody3D


func _ready() -> void:
	add_collision_exception_with(physical_col)
	physical_col.contact_monitor = true
	physical_col.max_contacts_reported = 10
	physical_col.body_entered.connect(hit)
	#cam_rc.add_exception($RigidBody3D)
'''
func _process(delta: float) -> void:
	cam_rc.target_position = (global_position - cam_rc.global_position).normalized() * 100
	cam_rc.force_raycast_update()
	if cam_rc.is_colliding():
		print(cam_rc.get_collider())
		if cam_rc.get_collider() != self:
			outline.show()
		else:
			outline.hide()'''
			
@onready var health_bar: ProgressBar = $"../Camera3D/Control/ProgressBar"
@onready var score_lab: Label = $"../Camera3D/Control/Score"


var health : float = 25
var hit_cooldown : float = 0
func hit(other):
	if hit_cooldown<=0:
		if other is Powerup:
			return
		
		if other is Item:
			health -= 5
			mouse_model.take_damage()
			hit_cooldown = 1
		if other is HeavyItem:
			health = 0
		elif other is Shard:
			health -= 1
			mouse_model.take_damage()
			hit_cooldown = 1
		
		
			#await get_tree().create_timer(0.5).timeout
			#get_tree().change_scene_to_file('res://ui/died_menu.tscn')
		
		
		


@onready var mouse_model: Node3D = $Mouse
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		mouse_model.jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("w", "s", "d", "a")
	mouse_model.direction = input_dir
	
	rotation.y += input_dir.y * delta * 4
	
	var direction := -(transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	
	
	#var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	health_bar.value = 100*(health/25)
	score_lab.text = 'Score: '+str(Global.score)
#	score_lab.text = 'Счет: '+str(get_tree().current_scene.score)
	
	if hit_cooldown>0:
		hit_cooldown -= delta
	
	
	if health<=0:
		var mdl = preload('res://Scenes/Player/mouse/fractured_mouse.tscn').instantiate()
		get_parent().add_child(mdl)
		mdl.global_position = global_position
		mdl.global_rotation = global_rotation
		$"../Camera3D/Control".hide()
		hide()
		
		var dead_scr = preload('res://ui/died_menu.tscn').instantiate()
		cam.add_child(dead_scr)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		set_process(false)
		set_physics_process(false)
	
	
	
