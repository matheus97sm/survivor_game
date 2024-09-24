extends Node

class_name Utils


func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)


func calculate_damage(weapon_attack: float, player: CharacterBody2D):
	var is_crit = randf() >= 1 - player.player_crit_rate
	var inflicted_damage = weapon_attack + player.player_attack
	
	if is_crit:
		inflicted_damage += inflicted_damage * player.player_crit_damage
	
	return inflicted_damage
