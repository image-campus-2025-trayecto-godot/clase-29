extends Button3D

@export var scene: PackedScene

func interact():
	super()
	var node = scene.instantiate()
	add_child(node)
	node.global_position = global_position
