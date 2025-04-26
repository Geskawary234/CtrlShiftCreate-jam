extends RigidBody3D


'''
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(Destroy)
	
@onready var model: Node3D = $Hammer_0
var parts = {}
func Destroy(other):
	for c in model.get_children():
		if c is MeshInstance3D:
			parts[c] = [c.position + global_position,c.rotation + global_rotation]
	
	freeze = true
	
	for p in parts.keys():
		var r := RigidBody3D.new()
		var m : MeshInstance3D = p.duplicate()

		r.add_child(m)
		m.create_trimesh_collision()
		
		r.add_child(m.get_children()[0].get_children()[0].duplicate())
		
		
		get_parent().add_child(r)
		r.global_position = parts[p][0]
		r.global_rotation = parts[p][1]
'''

@onready var dest : Destruction = get_node('Destruction')

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(fracture)



func fracture(other):
	dest.destroy(4)


	
	
	
