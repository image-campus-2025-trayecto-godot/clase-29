extends CSGBox3D

const LAMP_OFF_MATERIAL = preload("uid://33fm251tmefn")
const LAMP_ON_MATERIAL = preload("uid://c70okkdoa1fpd")

var is_on: bool = false

func _ready():
	update_light()

func toggle():
	is_on = !is_on
	update_light()

func update_light():
	$LampModel.material = LAMP_ON_MATERIAL if is_on else LAMP_OFF_MATERIAL
	$OmniLight3D.visible = is_on
