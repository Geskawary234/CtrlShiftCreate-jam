extends RigidBody3D
class_name Item

@onready var dest : Destruction = get_node('Destruction')

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(fracture)



func fracture(other):
	dest.destroy()
	$"../Camera3D".shake_duration = 0.2
	$"../Camera3D".shake()
	
	queue_free()
