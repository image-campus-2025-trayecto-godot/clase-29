extends Node3D

@export var next_level: PackedScene

@export var scenes_to_load: Array[PackedScene]
@onready var texture_progress_bar: TextureProgressBar = $CanvasLayer/TextureProgressBar
var scenes_loaded: int = 0

func _ready():
	texture_progress_bar.max_value = 10000 #scenes_to_load.size()
	texture_progress_bar.value = 0
	for scene in scenes_to_load:
		var node = scene.instantiate()
		add_child(node)
		node.set_physics_process(false)
		node.set_process(false)
		node.set_process_input(false)
		var children_3d = node.find_children("", "Node3D", true, false)
		var children_canvas_item = node.find_children("", "CanvasItem", true, false)
		for child in (children_3d + children_canvas_item):
			child.visible = true
		for i in range(120):
			await get_tree().process_frame
		scenes_loaded += 1
		#texture_progress_bar.value = 1 + texture_progress_bar.value

	get_tree().change_scene_to_packed(next_level)

func _process(delta: float) -> void:
	var target_progress = float(scenes_loaded) / scenes_to_load.size() * texture_progress_bar.max_value
	texture_progress_bar.value = lerp(texture_progress_bar.value, target_progress, 1 - pow(0.1, delta))
