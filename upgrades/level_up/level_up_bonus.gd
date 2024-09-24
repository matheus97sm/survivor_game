extends CanvasLayer

var level_up_button = preload("res://upgrades/level_up/level_up_bonus_button.tscn")
var player


func _ready() -> void:
	var upgrades = UpgradeBonus.new()
	upgrades.instantiate()
	var selected_upgrades = 0
	
	if player.has_second_gun:
		upgrades.upgrades = upgrades.upgrades.filter(func(upgrade): return filter_one_time_upgrades(upgrade, "extra_gun"))
	
	while selected_upgrades < 3:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var random_upgrade = rng.randi_range(0, upgrades.upgrades.size() - 1)
		
		var upgrade = upgrades.upgrades[random_upgrade]
		var new_level_up_button = level_up_button.instantiate()
		new_level_up_button.instantiate_button(upgrade.title, upgrade.description, upgrade.upgrade_type, upgrade.custom_icon)
		new_level_up_button.player = player
		new_level_up_button.global_position = %UpgradeSnapPoints.get_child(selected_upgrades).global_position
		%LevelUpBonusWrapper.add_child(new_level_up_button)
		
		selected_upgrades += 1
		upgrades.upgrades.pop_at(random_upgrade)


func filter_one_time_upgrades(upgrade, upgrade_type: String):
	return upgrade.upgrade_type != upgrade_type


func clean_upgrades():
	var upgrades = %LevelUpBonusWrapper.get_children()
	
	for upgrade in upgrades:
		upgrade.queue_free()
		
	get_parent().resume_game()
