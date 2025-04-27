extends Area3D

func _ready() -> void:
	body_entered.connect(entered)
	
func entered(body):
	if body is RigidBody3D and body is not Mouse_col and body is not MouseShard:
		body.queue_free()
	elif body is CharacterBody3D:
		body.health = 0
