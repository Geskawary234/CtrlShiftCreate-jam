extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var cam: Camera3D = $"../Camera3D"

func _ready() -> void:
	add_collision_exception_with($RigidBody3D)
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


func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("w", "s", "d", "a")
	
	rotation.y += input_dir.y * delta * 4
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	#var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
