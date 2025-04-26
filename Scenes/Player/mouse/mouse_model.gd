extends Node3D

@onready var head_target: Node3D = $Target
@onready var def_position : Vector3 = head_target.position
@onready var head_mod: LookAtModifier3D = $Armature/Skeleton3D/Head

@onready var overlay_mat : StandardMaterial3D = $Armature/Skeleton3D/mouse.material_overlay

var direction : Vector2
'''
func reset_position():
	head_target.position = def_position
'''
var turn_speed : float = 5
func _process(delta: float) -> void:
	if direction:
		head_target.position.z = move_toward(head_target.position.z,-3*direction.y,delta*turn_speed)
	else:
		head_target.position.z = move_toward(head_target.position.z,def_position.z,delta*turn_speed)

@onready var ap: AnimationPlayer = $AnimationPlayer2
func jump():
	ap.play("Jump")
	

func take_damage():
	var t = create_tween()
	t.tween_property(overlay_mat,'albedo_color',Color(1,0,0,0.5),0.2)
	await t.finished
	t = create_tween()
	t.tween_property(overlay_mat,'albedo_color',Color(1,0,0,0),0.2)
