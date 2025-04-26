extends Fractable

func hit(other):
	if other is Convoyer or other is Mouse_col:
		fracture(5)
