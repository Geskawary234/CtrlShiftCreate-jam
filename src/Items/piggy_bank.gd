extends Fractable

const COIN = preload("uid://ddld7wtjxuy3f")


func hit(other):
	super(other)
	
	if other is Convoyer or other is Mouse_col or other is CSGCombiner3D or other is Item:
		
		var offset_y : float = 0
		for i in range(1,randi_range(3,5)):
			var c := COIN.instantiate()
			add_child(c)
			
			c.global_position = global_position + Vector3(0,offset_y,0)
			offset_y += 0.2
			#c.linear_velocity = Vector3(randf(),randf(),randf()) * 5
		
		
		fracture(15)
	
	
		
