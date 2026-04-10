extends Area3D

@onready var size: Vector3 = $CollisionShape3D.shape.size
@onready var mouse : CharacterBody3D = %Mouse

var objects : Array[PackedScene] = [
	preload('res://Scenes/Items/fracturable/bottle.tscn'),
	preload('res://Scenes/Items/powerups/cheese.tscn'),
	preload('res://Scenes/Items/items/axe.tscn'),
	preload('res://Scenes/Items/heavy items/dumbbel.tscn'),
	preload('res://Scenes/Items/fracturable/gear.tscn'),
	preload('res://Scenes/Items/heavy items/iron_pipes.tscn'),
	preload('res://Scenes/Items/fracturable/toster.tscn'),
	preload('res://Scenes/Items/items/wrench.tscn'),
	preload('res://Scenes/Items/heavy items/heater.tscn'),
	preload('res://Scenes/Items/items/crowbar.tscn'),
	preload('res://Scenes/Items/fracturable/safe.tscn'),
	preload('res://Scenes/Items/heavy items/kettle_bell.tscn'),
	preload('res://Scenes/Items/heavy items/anvil.tscn'),
	preload('res://Scenes/Items/items/hammers/hammer_0.tscn'),
	preload('res://Scenes/Items/items/hammers/hammer_1.tscn'),
	preload('res://Scenes/Items/items/hammers/hammer_2.tscn'),
	preload('res://Scenes/Items/items/hammers/hammer_3.tscn'),
	preload('res://Scenes/Items/items/hammers/hammer_4.tscn')
]

var t : float = 0
var t_time : float = 0
var time_multiplier : float = 1
@export var spawning : bool = false
func _process(delta: float) -> void:
	if spawning and is_instance_valid(mouse):
		if t>=t_time:
			t_time = randf_range(0.3,1.5)
			
			var r : RigidBody3D = objects.pick_random().instantiate()
			
			
			r.mouse = mouse
			add_child(r)
			
			r.global_position = global_position + Vector3(randf_range(-size.x,size.x),randf_range(-size.y,size.y),randf_range(-size.z,size.z))/2
			r.global_rotation = Vector3(randf_range(-360,360),randf_range(-360,360),randf_range(-360,360))
			#r.angular_velocity = Vector3(randf_range(-5,5),randf_range(-5,5),randf_range(-5,5))
			r.freeze = false
			
			
			t = 0
		else:
			t+= delta * time_multiplier
			
		time_multiplier += delta / 10
		#print(time_multiplier)

	
