extends CharacterBody3D

@export var SPEED = 10.0
const JUMP_VELOCITY = 4.5

@export_range(0.0001, 0.01, 0.0001) var mouse_sensitivity: float = 0.015

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

var rot_x = 0
var rot_y = 0


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.MOUSE_MODE_CAPTURED == Input.mouse_mode:
		rotation.y -= event.screen_relative.x * mouse_sensitivity
		rotation.x -= event.screen_relative.y * mouse_sensitivity
		rotation.x = clampf(rotation.x, - PI / 4, PI / 4)
	if event.is_action_pressed("toggle_mouse_capture"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
