extends Area3D

func _ready() -> void:
	body_entered.connect(hit)

@onready var sch1: StaticBody3D = $"../Map/Schredder1/StaticBody3D"
@onready var sch2: StaticBody3D = $"../Map/Schredder2/StaticBody3D"

func hit(body):
	if body is Fractable or body is Fractable_destroyable_by_schredder:
		body.fracture(5)
	if body is CharacterBody3D:
		body.health = 0
	
	await get_tree().create_timer(1,false).timeout
	if is_instance_valid(body):
		sch1.add_collision_exception_with(body)
		sch2.add_collision_exception_with(body)

		
	
