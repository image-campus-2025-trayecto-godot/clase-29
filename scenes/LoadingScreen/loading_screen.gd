extends Node3D

@export var scenes_to_load: Array[PackedScene]

@export var next_scene: PackedScene


func _ready() -> void:
	for scene in scenes_to_load:
		var new_instance: Node = scene.instantiate()
		add_child(new_instance)
		new_instance.set_physics_process(false)
		new_instance.set_process(false)
		new_instance.set_process_input(false)
		for node in new_instance.find_children("", "Node3D", true, false):
			node.visible = true
	for i in range(120):
		await get_tree().process_frame
	get_tree().change_scene_to_packed(next_scene)
