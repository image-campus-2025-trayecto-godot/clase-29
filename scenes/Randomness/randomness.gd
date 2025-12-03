extends Control
@onready var item_list: ItemList = %ItemList

func _ready():
	$LineEdit.text_submitted.connect(func(seed_text: String):
		item_list.clear()
		seed(seed_text.hash())
	)
