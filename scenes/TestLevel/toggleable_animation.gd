extends AnimationPlayer

func toggle():
	if is_playing():
		stop()
	else:
		play()
