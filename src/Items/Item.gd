extends RigidBody3D
class_name Item

func _ready() -> void:
	add_collision_exception_with(get_tree().current_scene.mouse)
