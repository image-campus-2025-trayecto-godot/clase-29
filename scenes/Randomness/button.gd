extends Button
@onready var item_list: ItemList = %ItemList

func _pressed() -> void:
	var random_number = randi_range(1, 100)
	item_list.add_item(str(random_number))
