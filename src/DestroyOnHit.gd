extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(fracture)

func fracture(other):
	get_node('Destruction').destroy(7)
