extends Control

var prog_speed : float = 30

var ws_val : float = 0
var ad_val : float = 0
@onready var wsadlab: Label = $Label
@onready var ws_prog: ProgressBar = $"Label/WS progress"
@onready var ad_prog: ProgressBar = $"Label/AD progress"


@onready var mlab: Label = $"Use mouse to look around!"
@onready var mprog: ProgressBar = $"Use mouse to look around!/Mprog"

@onready var use_jump: Label = $"Use jump"
@onready var jprog: ProgressBar = $"Use jump/jprog"


func _process(delta: float) -> void:
	if Global.did_tutorial or %Mouse.health<=0:
		queue_free()
	else:
		if ws_val<100 or ad_val<100:
			if ws_val<100:
				if Input.get_axis('w','s'):
					ws_val += delta * prog_speed
				else:
					ws_val -= delta * prog_speed/5
				ws_val = clamp(ws_val,0,100)
			
			if ad_val<100:
				if Input.get_axis('a','d'):
					ad_val += delta * prog_speed
				else:
					ad_val -= delta * prog_speed/5
				ad_val = clamp(ad_val,0,100)
				
			
			ws_prog.value = ws_val
			ad_prog.value = ad_val
		
		else:
			if mprog.value<100:
				wsadlab.hide()
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
						jprog.value += 12.5
					else:
						jprog.value -= delta * prog_speed/5
				
				else:
					$"../../..".start_game()
					Global.did_tutorial = true
				
