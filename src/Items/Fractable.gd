extends Item
class_name Fractable


@export var fractured : PackedScene

func _ready() -> void:
	super._ready()
	contact_monitor = true
	max_contacts_reported = 10
	body_entered.connect(hit)

func hit(other):
	print(other)
	if other is RigidBody3D:
		fracture(5)

func fracture(power : int = 0):
	freeze = true
	var model = fractured.instantiate()
	get_parent().add_child(model)
	model.global_position = global_position
	model.global_rotation = global_rotation
	
	for i in model.get_children():
		if i is MeshInstance3D:
			
			i.create_convex_collision()
			var col = i.get_children()[0].get_children()[0].duplicate()
			i.get_children()[0].queue_free()
			col.scale = i.scale
			col.rotation = i.rotation
			
			
			var r = RigidBody3D.new()
			r.add_collision_exception_with(%Mouse)
			r.add_child(col)
			r.position = i.position
			r.linear_velocity = linear_velocity + r.position
			
			r.linear_velocity += Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1)) * power
			
			model.add_child(r)
			
			i.reparent(r)
	
	queue_free()
