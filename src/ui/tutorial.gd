extends Control

var prog_speed : float = 30

@onready var wasd_lab: Label = $Label
@onready var wasd_progress: ProgressBar = $"Label/WASD progress"


@onready var mlab: Label = $"Use mouse to look around!"
@onready var mprog: ProgressBar = $"Use mouse to look around!/Mprog"

@onready var use_jump: Label = $"Use jump"
@onready var jprog: ProgressBar = $"Use jump/jprog"
var animating : bool
var finished : bool = false

func _process(delta: float) -> void:
	if Global.did_tutorial or %Mouse.health<=0 or finished:
		hide()
		set_process(false)
	else:
		if animating: return
		
		if Input.is_action_just_pressed('e'):
			finish_up()
		
		if wasd_progress.value<wasd_progress.max_value:
			if Input.get_vector('w','a','s','d'):
				wasd_progress.value += delta * prog_speed
			else:
				wasd_progress.value -= delta * prog_speed/5
		
		else:
			if mprog.value<mprog.max_value:
				wasd_lab.hide()
				mlab.show()
				if Input.get_last_mouse_velocity().length()>0:
					mprog.value += delta * Input.get_last_mouse_velocity().length()/25
				else:
					mprog.value -= delta * prog_speed/5
				
				mprog.value = clamp(mprog.value,0,100)
			
			
			
			else:
				
				if jprog.value<jprog.max_value:
					mlab.hide()
					use_jump.show()
					if Input.is_action_just_pressed('ui_accept') and %Mouse.velocity.y>%Mouse.JUMP_VELOCITY-2:
						jprog.value += 50
					else:
						jprog.value -= delta * prog_speed/5
				
				else:
					
					
					finish_up()

func finish_up():
	animating = true
	
	var t := create_tween()
	await t.tween_property(self,'position',Vector2(position.x,position.y + 200),1).finished
					
	await get_tree().create_timer(0.5,false).timeout
	
	finished = true
	$"../../..".start_game()
					
					
