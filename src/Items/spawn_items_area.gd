extends Area3D

@onready var size: Vector3 = $CollisionShape3D.shape.size
@onready var mouse : CharacterBody3D = %Mouse

var objects : Array[PackedScene] = [
	preload('res://Scenes/Items/bottle.tscn'),
	preload('res://Scenes/Items/hammer.tscn'),
	preload('res://Scenes/Items/powerups/cheese.tscn'),
	preload('res://Scenes/Items/axe.tscn'),
	preload('res://Scenes/Items/dumbbel.tscn'),
	preload('res://Scenes/Items/gear.tscn'),
	preload('res://Scenes/Items/iron_pipes.tscn'),
	preload('res://Scenes/Items/toster.tscn'),
	preload('res://Scenes/Items/wrench.tscn'),
	preload("res://Scenes/Items/heater.tscn"),
	preload('res://Scenes/Items/crowbar.tscn')
]

var t : float = 0
var t_time : float = 0
var spawning : bool = false
func _process(delta: float) -> void:
	if spawning and is_instance_valid(mouse):
		if t>=t_time:
			t_time = randf_range(0.3,1.5)
			
			var r : RigidBody3D = objects.pick_random().instantiate()
			
			
			r.mouse = mouse
			add_child(r)
			
			r.global_position = global_position + Vector3(randf_range(-size.x,size.x),randf_range(-size.y,size.y),randf_range(-size.z,size.z))/2
			#r.global_rotation = Vector3(randf_range(-360,360),randf_range(-360,360),randf_range(-360,360))
			#r.angular_velocity = Vector3(randf_range(-5,5),randf_range(-5,5),randf_range(-5,5))
			r.freeze = false
			
			
			t = 0
		else:
			t+=delta

	
