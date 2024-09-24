extends Node


class_name UpgradeBonus

var damage_upgrade_icon = preload("res://sprites/DamageUpgrade.png")
var health_upgrade_icon = preload("res://sprites/HealthUpgrade.png")
var crit_dmg_upgrade_icon = preload("res://sprites/CritDmgUpgrade.png")
var crit_rate_upgrade_icon = preload("res://sprites/CritRateUpgrade.png")
var extra_gun_upgrade_icon = preload("res://sprites/ExtraGunUpgrade.png")
var speed_upgrade_icon = preload("res://sprites/SpeedUpgrade.png")

var upgrades = []

func instantiate() -> void:
	var new_damage_icon = Sprite2D.new()
	new_damage_icon.texture = damage_upgrade_icon
	var attack_upgrade: = {
		"upgrade_type" = "attack",
		"title" = "Base attack +2",
		"description" = "Adds +2 to your base attack, that will increase the damage from all weapons.",
		"custom_icon" = new_damage_icon
	}
	upgrades.append(attack_upgrade)
	
	var new_health_icon = Sprite2D.new()
	new_health_icon.texture = health_upgrade_icon
	var health_upgrade = {
		"upgrade_type" = "health",
		"title" = "Total health +100",
		"description" = "Adds +100 to your total health.",
		"custom_icon" = new_health_icon
	}
	upgrades.append(health_upgrade)
	
	var new_crit_dmg_icon = Sprite2D.new()
	new_crit_dmg_icon.texture = crit_dmg_upgrade_icon
	var crit_dmg_upgrade = {
		"upgrade_type" = "crit_dmg",
		"title" = "Crit DMG +10%",
		"description" = "Adds +10% to your crit damage, that will increase the crit damage from all weapons.",
		"custom_icon" = new_crit_dmg_icon
	}
	upgrades.append(crit_dmg_upgrade)
	
	var new_crit_rate_icon = Sprite2D.new()
	new_crit_rate_icon.texture = crit_rate_upgrade_icon
	var crit_rate_upgrade = {
		"upgrade_type" = "crit_rate",
		"title" = "Crit rate +5%",
		"description" = "Adds +5% to your crit rate, that will increase the crit chance from all weapons. The maximum crit rate is 35%.",
		"custom_icon" = new_crit_rate_icon
	}
	upgrades.append(crit_rate_upgrade)
	
	var new_extra_gun_icon = Sprite2D.new()
	new_extra_gun_icon.texture = extra_gun_upgrade_icon
	var extra_gun_upgrade = {
		"upgrade_type" = "extra_gun",
		"title" = "Adds an extra gun",
		"description" = "Adds a second gun, that will shoot randomly at enemies. The extra gun does not have upgrades.",
		"custom_icon" = new_extra_gun_icon
	}
	upgrades.append(extra_gun_upgrade)
	
	var new_speed_icon = Sprite2D.new()
	new_speed_icon.texture = speed_upgrade_icon
	var speed_upgrade = {
		"upgrade_type" = "speed",
		"title" = "Speed +5%",
		"description" = "Increases the player movement speed in 5%.",
		"custom_icon" = new_speed_icon
	}
	upgrades.append(speed_upgrade)
