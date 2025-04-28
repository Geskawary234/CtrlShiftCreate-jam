extends Node3D

var power : float = 5
var mat = preload("res://Assets/Materials/mouse_skin.tres")

func _ready() -> void:
	
	for i in get_children():
		if i is MeshInstance3D:
			
			i.create_convex_collision()
			var col = i.get_children()[0].get_children()[0].duplicate()
			i.get_children()[0].queue_free()
			#col.scale = i.scale
			#col.rotation = i.rotation
			
			
			var r = RigidBody3D.new()
			r.continuous_cd = true
			r.set_script(preload('res://src/Items/mouse_shard.gd'))
			r.add_child(col)
			
			$Container.add_child(r)
			
			r.position = i.position
			
			i.reparent(r)
			
			if i.name not in ['mouse_001','mouse_002']:
				i.set_surface_override_material(0,mat)
				
			
			#r.linear_velocity = linear_velocity + r.position
			
			r.linear_velocity = Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1)) * power
	
	$AudioStreamPlayer3D.play()
	$Container/GPUParticles3D.emitting = true
	$Container/GPUParticles3D2.emitting = true
	var decal = Decal.new()
	decal.texture_albedo = preload("res://Assets/Textures/blood_decal.png")
	decal.size = Vector3(5,10,5)
	get_parent().add_child(decal)
	decal.global_position = $AudioStreamPlayer3D.global_position
	decal.rotation_degrees.y = randf_range(-360,360)
			
			
