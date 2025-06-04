extends Control

var prog_speed : float = 30

@onready var wasd_lab: Label = $Label
@onready var wasd_progress: ProgressBar = $"Label/WASD progress"


@onready var mlab: Label = $"Use mouse to look around!"
@onready var mprog: ProgressBar = $"Use mouse to look around!/Mprog"

@onready var use_jump: Label = $"Use jump"
@onready var jprog: ProgressBar = $"Use jump/jprog"


func _process(delta: float) -> void:
	if Global.did_tutorial or %Mouse.health<=0:
		queue_free()
	else:
		if wasd_progress.value<100:
			if Input.get_vector('w','a','s','d'):
				wasd_progress.value += delta * prog_speed
			else:
				wasd_progress.value -= delta * prog_speed/5
		
		else:
			if mprog.value<100:
				wasd_lab.hide()
				mlab.show()
				if Input.get_last_mouse_velocity().length()>0:
					mprog.value += delta * Input.get_last_mouse_velocity().length()/25
				else:
					mprog.value -= delta * prog_speed/5
				
				mprog.value = clamp(mprog.value,0,100)
			
			
			
			else:
				
				if jprog.value<100:
					mlab.hide()
					use_jump.show()
					if Input.is_action_just_pressed('ui_accept') and %Mouse.velocity.y>%Mouse.JUMP_VELOCITY-2:
						jprog.value += 50
					else:
						jprog.value -= delta * prog_speed/5
				
				else:
					$"../../..".start_game()
					Global.did_tutorial = true
				
