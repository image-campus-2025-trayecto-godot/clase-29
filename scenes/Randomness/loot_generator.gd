extends Control

@export var random_seed: String = ""
@export var monsters: Array[Monster] = []
@export var loot_items: Array[Loot] = []

var current_monster: Monster = null
var journal_entries: Array[String] = []

var monster_rng = RandomNumberGenerator.new()
var items_rng = RandomNumberGenerator.new()

func _ready() -> void:
	if random_seed:
		monster_rng.seed = random_seed.hash()
		items_rng.seed = random_seed.hash()
		seed(random_seed.hash())
	else:
		monster_rng.randomize()
		items_rng.randomize()
		randomize()

func _on_find_monster_button_pressed() -> void:
	current_monster = get_random_monster()
	%MonsterLabel.text = current_monster.monster_emoji + " " + current_monster.monster_name
	%MonsterLabel.modulate = current_monster.monster_color

	%MonsterPanel.visible = true
	%ResultPanel.visible = false


func get_random_monster() -> Monster:
	#var roll = monster_rng.randf()
	var weighs = PackedFloat32Array(monsters.map(func(monster): return monster.probability))
	var idx = monster_rng.rand_weighted(weighs)
	return monsters[idx]
	#var cumulative = 0.0
	#
	#for monster in monsters:
		#cumulative += monster.probability
		#if roll < cumulative:
			#return monster
	#
	#return monsters.front()


func _on_fight_button_pressed() -> void:
	var item: Loot = loot_items[items_rng.randi() % loot_items.size()]
	
	%ResultLabel.text = "⚔️ Victory! ⚔️"
	%ResultLabel.modulate = Color("#FFD700")
	%LootLabel.text = item.item_emoji + " " + item.item_name
	%LootLabel.modulate = item.item_color
	
	%MonsterPanel.visible = false
	%ResultPanel.visible = true

	var monster_text = current_monster.monster_emoji + " " + current_monster.monster_name
	var item_text = item.item_emoji + " " + item.item_name
	add_journal_entry("⚔️ Fought %s → Got %s" % [monster_text, item_text])


func _on_skip_button_pressed() -> void:
	%ResultLabel.text = "🏃 Skipped! 🏃"
	%ResultLabel.modulate = Color("#FFA500")
	%LootLabel.text = "❌ No loot"
	%LootLabel.modulate = Color("#FF6347")
	
	%MonsterPanel.visible = false
	%ResultPanel.visible = true

	var monster_text = current_monster.monster_emoji + " " + current_monster.monster_name
	add_journal_entry("🏃 Found %s → Skipped" % monster_text)


func add_journal_entry(entry: String) -> void:
	journal_entries.append(entry)
	update_journal()


func update_journal() -> void:
	var text = "\n\n".join(journal_entries)
	%JournalLabel.text = text if text != "" else "✨ Your adventure begins... ✨"


func _on_export_journal_button_pressed() -> void:
	if journal_entries.is_empty():
		return
	
	var file_path = "user://journal_export.txt"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	
	if file:
		file.store_string("=== MONSTER HUNTER JOURNAL ===\n")
		if random_seed:
			file.store_string("Seed: %s\n" % random_seed)
		file.store_string("=================================\n\n")
		
		for entry in journal_entries:
			file.store_string(entry + "\n\n")
		
		file.close()
		OS.shell_open(file.get_path_absolute())
		print("Journal exported to: ", ProjectSettings.globalize_path(file_path))
