@tool 
extends Area3D

@export var blast_radius : float = 1:
	set(val):
		blast_radius = val
		if is_instance_valid($CollisionShape3D):
			$CollisionShape3D.shape.radius = blast_radius
		
@onready var shockwave: MeshInstance3D = $MeshInstance3D
@export_color_no_alpha var shockwave_color :
	set(val):
		shockwave_color = val
		if is_instance_valid(shockwave):
			var mat = shockwave.get_surface_override_material(0)
			mat.albedo_color = val
	
@export var max_force : float = 10



func _ready() -> void:
	shockwave.scale = Vector3.ZERO
	
	
	if !Engine.is_editor_hint():
		var t = get_tree().create_tween()
		
		t.parallel().tween_property(shockwave,'scale',Vector3.ONE * blast_radius * 1.75,0.5)
		var mat = shockwave.get_surface_override_material(0)
		t.parallel().tween_property(mat,'albedo_color',Color(shockwave_color.r,shockwave_color.g,shockwave_color.b,0),1)
		
		
		for obj in get_overlapping_bodies():
			if obj is Item:
				var dist_fact : float = 1-(obj.global_position.distance_to(global_position)/blast_radius)
				obj.linear_velocity = (obj.global_position - global_position).normalized() * dist_fact
		
		await t.finished
		queue_free()
