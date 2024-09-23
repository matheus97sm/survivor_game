extends Node


class_name UpgradeBonus

@onready var damage_upgrade_icon = preload("res://sprites/DamageUpgrade.png")
@onready var health_upgrade_icon = preload("res://sprites/HealthUpgrade.png")
@onready var crit_dmg_upgrade_icon = preload("res://sprites/CritDmgUpgrade.png")

var upgrades = []

func instantiate() -> void:
	var attack_upgrade = Object.new()
	attack_upgrade.upgrade_type = "attack"
	attack_upgrade.title = "Base attack +2"
	attack_upgrade.description = "Adds +2 to your base attack, that will increase the damage from all weapons."
	attack_upgrade.custom_icon = damage_upgrade_icon
	upgrades.append(attack_upgrade)
	
	var health_upgrade = Object.new()
	health_upgrade.upgrade_type = "health"
	health_upgrade.title = "Total health +100"
	health_upgrade.description = "Adds +100 to your total health."
	health_upgrade.custom_icon = health_upgrade_icon
	upgrades.append(health_upgrade)
	
	var crit_dmg_upgrade = Object.new()
	crit_dmg_upgrade.upgrade_type = "crit_dmg"
	crit_dmg_upgrade.title = "Crit DMG +10%"
	crit_dmg_upgrade.description = "Adds +10% to your crit damage, that will increase the crit damage from all weapons."
	crit_dmg_upgrade.custom_icon = crit_dmg_upgrade_icon
	upgrades.append(crit_dmg_upgrade)
	
