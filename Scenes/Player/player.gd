extends CharacterBody3D
class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sens = 0.004

@onready var cam_arm: SpringArm3D = $SpringArm3D
@onready var camera_pivot: Node3D = $SpringArm3D/CameraPivot
@onready var cam: Camera3D = $SpringArm3D/CameraPivot/Camera3D
@onready var rbchecker: RayCast3D = $RBchecker
@onready var body_attractor: Node3D = $BodyAttractor

var item : RigidBody3D = null

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sens)
		cam_arm.rotate_x(event.relative.y * sens)
		cam_arm.global_rotation_degrees.x = clamp(cam_arm.rotation_degrees.x,-60,50)
		cam_arm.rotation.z = 0
		cam_arm.rotation_degrees.y = -180

func _process(delta: float) -> void:
	body_attractor.position = cam_arm.basis.z * -3

var pressed_timer : float = 0
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed('e'):
		if item==null:
			if rbchecker.is_colliding():
				if rbchecker.get_collider() is RigidBody3D:
					item = rbchecker.get_collider()
					add_collision_exception_with(item)
		elif is_instance_valid(item):
			remove_collision_exception_with(item)
			item = null
			
		
	if is_instance_valid(item):
		var dist : float = body_attractor.global_position.distance_to(item.global_position)
		item.linear_velocity = dist * 25 * (body_attractor.global_position - item.global_position).normalized()
		
	if Input.is_action_pressed('lmb'):
		pressed_timer += delta
		if pressed_timer>=1:
			shot()
	else:
		pressed_timer = 0
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("d", "a", "s", "w")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func shot():
	var r := RigidBody3D.new()
	var c := CollisionShape3D.new()
	var m := MeshInstance3D.new()
	
	m.mesh = BoxMesh.new()
	m.mesh.size = Vector3(0.5,0.5,0.5)
	
	c.shape = BoxShape3D.new()
	c.shape.size = m.mesh.size
	
	r.add_child(c)
	r.add_child(m)
	
	get_parent().add_child(r)
	r.global_position = -cam.global_basis.z*3 + cam.global_position
	r.linear_velocity = -cam.global_basis.z*40
