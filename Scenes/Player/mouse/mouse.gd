extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 4.5

@export var cam: Camera3D
@onready var physical_col: RigidBody3D = $RigidBody3D


func _ready() -> void:
	cam.set_blur(false)
	add_collision_exception_with(physical_col)
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
			
@onready var health_bar: ProgressBar = $"../CamPivot/Camera3D/Control/ProgressBar"
@onready var score_lab: Label = $"../CamPivot/Camera3D/Control/Score"


var health : float = 25
var hit_cooldown : float = 0
func hit(col : KinematicCollision3D):

	for i in col.get_collision_count():
	
		var object = col.get_collider(i)
		var vel : Vector3 = col.get_collider_velocity(i)
		
		if object is Powerup: return
		
		if object is Item or object is Shard:
			
			
			if hit_cooldown>0: return
			
			var dot_product : float = -vel.normalized().dot(velocity.normalized())
			dot_product = clamp(dot_product,0,1)
			
			var damage : float = dot_product * object.max_damage
			#print(dot_product, ' ',object.name)
			
			if damage>0:
				hit_cooldown = 1
				health -= damage
				mouse_model.take_damage()
			
			
		
		
	
	
	'''
	if hit_cooldown<=0:
		if other is Powerup:
			return
		
		if other is Item or other is Shard:
	
			
			var k = -other.linear_velocity.normalized().dot(velocity.normalized())
			k = clamp(k,0,1)
			
			var res_damage : float = other.max_damage * k * 2
			
			if res_damage>0:
				hit_cooldown = 1
				health -= res_damage
				mouse_model.take_damage()
			
			
			#await get_tree().create_timer(0.5).timeout
			#get_tree().change_scene_to_file('res://ui/died_menu.tscn')
		'''
		
		


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
	var input_dir := Input.get_vector("d", "a", "s", "w")
	mouse_model.direction = input_dir
	
	#rotation.y += input_dir.y * delta * 4
	var direction := -(cam.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	
	#var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		var ang := Vector2(direction.x,-direction.z).angle()
		rotation.y = lerp_angle(rotation.y,ang,0.1)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	
	move_and_slide()
	
	var last_col : = get_last_slide_collision()
	if last_col:
		hit(last_col)
		

func _process(delta: float) -> void:
	if is_instance_valid(health_bar) and is_instance_valid(score_lab):
		health_bar.value = 100*(health/25)
		score_lab.text = 'Score: '+str(Global.score)
#	score_lab.text = 'Счет: '+str(get_tree().current_scene.score)
	
	if hit_cooldown>0:
		hit_cooldown -= delta
	
	
	if health<1:
		death()
	

func death():
	var mdl = preload('res://Scenes/Player/mouse/fractured_mouse.tscn').instantiate()
	get_parent().add_child(mdl)
	mdl.global_position = global_position
	mdl.global_rotation = global_rotation
	cam.get_node('Control').hide()
	hide()
		
	var dead_scr = preload('res://ui/died_menu.tscn').instantiate()
	cam.add_child(dead_scr)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	cam.set_blur(true)
	set_process(false)
	set_physics_process(false)
	
