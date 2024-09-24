extends Button

var upgrade_type
var player

@export var item: InventoryItem


func instantiate_button(title: String, description: String, loaded_type: String, custom_icon: Sprite2D):
	upgrade_type = loaded_type
	%LevelUpIcon.add_child(custom_icon)
	%LevelUpTitle.text = title
	%LevelUpDescription.text = description


func _on_button_down() -> void:	
	player.level_upgrade_bonus(upgrade_type)
