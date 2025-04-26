extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var cam: Camera3D = $"../Camera3D"



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
	var col = move_and_collide(velocity.normalized() * delta,false,0.001,true,10)
	if col:
		if col.get_normal().y != 1:
			velocity = -velocity.normalized() * 7
