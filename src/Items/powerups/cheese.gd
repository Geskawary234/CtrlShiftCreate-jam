extends Powerup


func _ready() -> void:
	super._ready()
	

func hit(other):
	var player = super.hit(other)
	
	if player:
		player.health = 25
	
		queue_free()
