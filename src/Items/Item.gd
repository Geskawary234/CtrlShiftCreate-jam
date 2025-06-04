extends RigidBody3D
class_name Item

var mouse : CharacterBody3D
var max_damage : float = 5

func _ready() -> void:
	if !mouse:
		mouse = %Mouse
	add_collision_exception_with(mouse)
