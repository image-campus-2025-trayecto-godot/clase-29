extends GPUParticles3D

@export var time_to_live: float = 5.0

func _ready() -> void:
	await get_tree().create_timer(time_to_live).timeout
	emitting = false
	await finished
	queue_free()
