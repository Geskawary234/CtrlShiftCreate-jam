extends RigidBody3D
class_name Item

var mouse : CharacterBody3D

func _ready() -> void:
	add_collision_exception_with(mouse)
