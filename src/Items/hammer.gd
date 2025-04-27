extends ItemSound
class_name HammerItem

var hammers : Array[PackedScene] = [
	preload('res://Assets/Models/Hammers/Hammer_0.glb'),
	preload('res://Assets/Models/Hammers/Hammer_1.gltf'),
	preload('res://Assets/Models/Hammers/Hammer_2.gltf'),
	preload('res://Assets/Models/Hammers/Hammer_3.gltf'),
	preload('res://Assets/Models/Hammers/Hammer_4.gltf')
]


func _ready() -> void:
	super._ready()
	var h = hammers.pick_random().instantiate()
	add_child()
	
	
