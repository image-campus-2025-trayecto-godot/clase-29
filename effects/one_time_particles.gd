extends GPUParticles3D

func _ready() -> void:
	one_shot = true
	restart()
	await finished
	queue_free()
