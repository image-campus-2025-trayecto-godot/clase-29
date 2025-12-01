extends Node3D

@export var light: OmniLight3D

func toggle():
	light.shadow_enabled = !light.shadow_enabled
