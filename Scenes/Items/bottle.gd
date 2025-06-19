extends Fractable

func hit(other):
	if other is Convoyer or other is Mouse_col or other is CSGCombiner3D:
		fracture(5)
