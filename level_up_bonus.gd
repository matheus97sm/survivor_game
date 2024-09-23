extends CanvasLayer

@onready var gun = preload("res://gun.tscn")
@onready var player = get_node("/root/Game/Player")
#@onready var custom_icon = preload("res://sprites/DamageUpgrade.png")

#var upgrades = []


func _ready() -> void:
	var upgrades = UpgradeBonus.new()
	upgrades.instantiate()
	print(upgrades.upgrades)
	#var attack_upgrade = Object.new()
	#attack_upgrade.title = "Base attack +2"
	#attack_upgrade.description = "Adds +2 to your base attack, that will increase the damage from all weapons."
	#attack_upgrade.custom_icon = custom_icon
	#upgrades.push_back()


func _on_new_weapon_bonus_button_down() -> void:
	var new_gun = gun.instantiate()
	player.add_child(new_gun)
	visible = false
	get_tree().paused = false
