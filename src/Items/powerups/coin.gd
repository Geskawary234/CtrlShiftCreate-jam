extends Powerup


func hit(other):
	var player = super.hit(other)
	
	if player:
		Global.score += 5
	
	queue_free()
