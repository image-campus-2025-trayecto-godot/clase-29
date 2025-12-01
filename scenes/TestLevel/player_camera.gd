extends Camera3D

const RAY_LENGTH = 1000
@onready var interaction_ray_cast_3d: RayCast3D = $InteractionRayCast3D

var interactable_node: Node3D = null

func _physics_process(delta: float) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		set_interactable_node(null)
		return
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_visible_rect().get_center()

	var origin = project_ray_origin(mousepos)
	var normal = project_ray_normal(mousepos)

	interaction_ray_cast_3d.global_rotation = Vector3.ZERO
	interaction_ray_cast_3d.target_position = normal * interaction_ray_cast_3d.target_position.length()
	interaction_ray_cast_3d.force_raycast_update()

	var collider = interaction_ray_cast_3d.get_collider()
	var new_interactable_node
	if collider and collider.get("interactable"):
		set_interactable_node(collider.interactable)
	else:
		set_interactable_node(null)

	if Input.is_action_just_pressed("interact"):
		if interactable_node:
			interactable_node.interact()

func set_interactable_node(node):
	if interactable_node == node:
		return
	if interactable_node:
		interactable_node.in_sight = false
	interactable_node = node
	if interactable_node:
		interactable_node.in_sight = true
