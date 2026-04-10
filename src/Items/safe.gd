extends Fractable

func hit(other):
	super.hit(other)
	if randi_range(0,2)==0:
		fracture(5)
