class_name Spawner
extends Node3D

@export var scene: PackedScene

func spawn():
	var node = scene.instantiate()
	add_child(node)
