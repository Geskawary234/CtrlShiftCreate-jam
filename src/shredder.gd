extends Area3D



func _on_shredder_body_entered(body: Node3D) -> void:
	if body is Fractable:
		body.fracture(5)
	
	elif body is Mouse_col:
		body.get_parent().health = 0
		body.get_parent().hit(self)
