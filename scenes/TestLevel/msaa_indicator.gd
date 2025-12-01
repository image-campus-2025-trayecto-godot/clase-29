extends Node3D

enum Mode {
	Disabled,
	x2,
	x4,
	x8
}

var mode = Mode.Disabled
@onready var label_3d: Label3D = $Label3D

func toggle():
	mode = (Mode.values().find(mode) + 1) % Mode.size()
	var modes = {
		Mode.Disabled: Viewport.MSAA_DISABLED,
		Mode.x2: Viewport.MSAA_2X,
		Mode.x4: Viewport.MSAA_4X,
		Mode.x8: Viewport.MSAA_8X,
	}
	get_viewport().msaa_3d = modes[mode]
	label_3d.text = "MSAA: %s" % Mode.keys()[mode]
