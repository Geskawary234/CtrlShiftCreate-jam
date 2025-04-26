extends StaticBody3D
class_name Convoyer
@onready var area_3d: Area3D = $Area3D
@onready var conv_mesh: MeshInstance3D = $MeshInstance3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mat = conv_mesh.mesh.surface_get_material(0)
	mat.uv1_offset.x += delta
	for obj in area_3d.get_overlapping_bodies():
		if obj is CharacterBody3D:
			obj.velocity.x = 5
		elif obj is RigidBody3D:
			obj.linear_velocity.x = -5
