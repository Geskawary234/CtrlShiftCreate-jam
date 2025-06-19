extends CharacterBody3D

var speed = 3

var player : CharacterBody3D
var creator : Node3D

@onready var dir : Vector3 = (player.global_position - global_position).normalized()
func _physics_process(delta: float) -> void:
	dir = dir.move_toward((player.global_position - global_position).normalized(),delta/2)
	
	velocity = dir * speed
	
	look_at(global_position + velocity)
	
	move_and_slide()

var robot_body : StaticBody3D
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body != robot_body:
		explode()


func explode():
	var mat = $Cylinder.get_active_material(1).duplicate()
	
	var m = MeshInstance3D.new()
	
	m.mesh = SphereMesh.new()
	m.set_surface_override_material(0,mat)
	
	
	get_parent().add_child(m)
	
	
	m.global_position = global_position + $Cylinder.global_basis.y * 8
	
	
	
	var t = get_parent().create_tween()
	t.parallel().tween_property(m,'scale',Vector3.ONE*5,0.3)
	creator.dropped_objects[m] = 1
	
	queue_free()
