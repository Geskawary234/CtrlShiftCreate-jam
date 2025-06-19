extends Node3D

@onready var head: MeshInstance3D = $head

@export var player : CharacterBody3D

func _ready() -> void:
	animate_head()

func animate_head() -> void:
	var t = create_tween()
	t.tween_property(head,'rotation_degrees',Vector3(0,rotation_degrees.y + randf_range(-90,90),0),0.5)
	await t.finished
	await get_tree().create_timer(randi_range(0,2),false).timeout
	animate_head()




### BOssfight

var objects : Array[PackedScene] = [
	preload('res://Scenes/Items/bottle.tscn'),
	preload('res://Scenes/Items/powerups/cheese.tscn'),
	preload('res://Scenes/Items/axe.tscn'),
	preload('res://Scenes/Items/dumbbel.tscn'),
	preload('res://Scenes/Items/gear.tscn'),
	preload('res://Scenes/Items/iron_pipes.tscn'),
	preload('res://Scenes/Items/toster.tscn'),
	preload('res://Scenes/Items/wrench.tscn'),
	preload("res://Scenes/Items/heater.tscn"),
	preload('res://Scenes/Items/crowbar.tscn'),
	preload('res://Scenes/Items/safe.tscn'),
	preload('res://Scenes/Items/kettle_bell.tscn'),
	preload('res://Scenes/Items/anvil.tscn')
]
var attack_type : int = 1
var attacking : bool = false
var attack_timer : float = 0
func _process(delta: float) -> void:
	clear_objects(delta) 
	
	if !attacking and attack_timer<=0:
		attacking = true
		if attack_type == 0:
			await drop_items()
		if attack_type == 1:
			var r = preload('res://Scenes/levels/Bossfight 1/rocket.tscn').instantiate()
			r.robot_body = $StaticBody3D
			r.player = player
			r.creator = self
			get_parent().add_child(r)
			
			r.global_position = global_position + Vector3(0,2,0)
			
			
		attacking = false
		attack_timer = randf_range(5,10)
		attack_type = randi_range(0,1)
	
	elif attack_timer>0:
		attack_timer -= delta
			

func drop_items():
	var count := randi_range(5,10)
	var time_between_each_spawn := randf_range(2,5) / count
	
	var items : Array[PackedScene] = []
	for i in range(count):
		items.append(objects.pick_random())
		
	for i in items:
		var obj = i.instantiate()
		
		dropped_items.add_child(obj)
		
		obj.global_position = player.global_position
		obj.global_position.y += 10
		
		dropped_objects[obj] = 5 
		
		await get_tree().create_timer(time_between_each_spawn,false).timeout

	return 0	

@onready var dropped_items: Node = $"../DroppedItems"
var dropped_objects : Dictionary = {}
func clear_objects(delta):
	for n in dropped_items.get_children():
		if n not in dropped_objects.keys():
			dropped_objects[n] = 5
	
	
	for i in dropped_objects.keys():
		if dropped_objects[i]>0:
			dropped_objects[i] -= delta
		else:
			dropped_objects.erase(i)
			if is_instance_valid(i):
				i.queue_free()
			
	
	
