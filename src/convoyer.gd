extends StaticBody3D
class_name Convoyer

@export var speed : float

@onready var conv_mesh: MeshInstance3D = $"../Map/Cube_009"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mat = conv_mesh.mesh.surface_get_material(0)
	mat.uv1_offset.x += delta * speed * 2.6
	constant_linear_velocity.x = move_toward(constant_linear_velocity.x,-speed,delta)
