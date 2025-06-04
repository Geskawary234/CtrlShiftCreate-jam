@tool
extends Node3D

@onready var rc1: RayCast3D = $RayCast3D
@onready var rc2: RayCast3D = $RayCast3D2

func _process(delta: float) -> void:
	var npos1 = rc1.target_position.normalized()
	var npos2 = rc2.target_position.normalized()
	var prod = npos1.dot(npos2)
	print(prod)
