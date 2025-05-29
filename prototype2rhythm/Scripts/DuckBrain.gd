extends AnimatedSprite2D

var initialQuacks = [117,118,120,122,123,124,126,133,134,136,138,139,140,142,
149,150,152,154,155,156,158,160,162,164,166,168,169,170,171,172,174,175, 181,
182,184,186,187,188,190,197,198,200,202,203,204,206,213,214,216,218,219,220,
222,224,226,227,228,230,232,233,234,235,236,237,238]


func playLaugh(measure):
		if (measure == 18 || measure == 22):
			play("Laugh")

func playQuack(note):
	if (initialQuacks.has(note)):
		play("Quack")
