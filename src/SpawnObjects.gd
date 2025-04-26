extends Node3D
@onready var mouse : CharacterBody3D = %Mouse

'''
var t : float = 0
var t_time : float = 0
@onready var spawn_pos : Vector3 = $CSGCombiner3D/CSGBox3D2.global_position
func _process(delta: float) -> void:
	if t>=t_time:
		t_time = randf_range(0.3,1.5)
		
		var r : RigidBody3D = objects.pick_random().duplicate()
		add_child(r)
		#r.set_script(preload('res://src/DestroyOnHit.gd'))
		r.global_position = Vector3(spawn_pos.x + randi_range(-2,2),5,spawn_pos.z + randi_range(-20,20))
		r.global_rotation = Vector3(randf_range(-360,360),randf_range(-360,360),randf_range(-360,360))
		#r.angular_velocity = Vector3(randf_range(-5,5),randf_range(-5,5),randf_range(-5,5))
		r.freeze = false
		
		
		t = 0
	else:
		t+=delta
'''
