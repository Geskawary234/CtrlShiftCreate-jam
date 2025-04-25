extends Node3D

@onready var obj: RigidBody3D = $Obj


var t : float = 0
var t_time : float = 0
func _process(delta: float) -> void:
	if t>=t_time:
		t_time = randf_range(0.3,1.5)
		
		var r = obj.duplicate()
		add_child(r)
		r.set_script(preload('res://src/DestroyOnHit.gd'))
		r.global_position = Vector3(randi_range(-5,5),5,randi_range(-5,5))
		r.freeze = false
		
		t = 0
	else:
		t+=delta
