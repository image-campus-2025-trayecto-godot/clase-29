extends CSGBox3D

var is_on: bool = false

func _ready():
	update_light()

func toggle():
	is_on = !is_on
	update_light()

func update_light():
	$LampOn.visible = is_on
	$LampOff.visible = !is_on
	$OmniLight3D.visible = is_on
