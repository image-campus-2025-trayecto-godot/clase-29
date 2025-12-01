class_name Button3D
extends Node3D

@export var text: String = "Click" :
	set(new_value):
		text = new_value
		if not is_node_ready():
			await ready
		if text:
			click_indicator.text = new_value

@onready var area_3d: Area3D = $Area3D
@onready var click_indicator: Label3D = $ClickIndicator
@onready var animation_player: AnimationPlayer = $"button-floor-round2/AnimationPlayer"

var in_sight: bool = false
signal pressed

func _ready():
	if text:
		click_indicator.text = text

func _process(delta: float) -> void:
	var target_label_scale := Vector3.ONE if in_sight else Vector3.ZERO
	click_indicator.scale = lerp(click_indicator.scale, target_label_scale, 1 - pow(0.0001, delta))

func interact():
	animation_player.play("toggle")
	pressed.emit()
