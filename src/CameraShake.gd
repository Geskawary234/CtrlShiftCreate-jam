extends Camera3D

@export var shake_magnitude : float = 0.1
@export var shake_duration : float = 0.2
@export var shake_fade_out_speed : float = 1.0

var current_shake_duration : float = 0.0
var initial_position : Vector3

func _ready():
	initial_position = position # Store the initial world position
	
	shake()

# Call this function to initiate the shake
func shake():
	current_shake_duration = shake_duration
	
func _process(delta):
	
	
	if current_shake_duration > 0:
		# Generate random shake offset on x and y axes only
		var x_offset = randf_range(-1.0, 1.0) * shake_magnitude
		var y_offset = randf_range(-1.0, 1.0) * shake_magnitude

		# Apply shake offset to the initial position
		position = initial_position + Vector3(x_offset, y_offset, 0.0)

		# Reduce shake duration
		current_shake_duration -= delta * shake_fade_out_speed
	else:
		# Reset to initial position when shake is done
		position = initial_position
		current_shake_duration = 0.0 # Ensure it doesn't go negative
