extends Node2D

@onready var new_damage_upgrade = preload("res://weapon/upgrade_damage.tscn")
@onready var new_speed_upgrade = preload("res://weapon/upgrade_speed.tscn")
@onready var new_shuriken_upgrade = preload("res://weapon/upgrade_shuriken.tscn")
@onready var new_life_restore = preload("res://upgrades/life/health_restore.tscn")
@onready var new_life_upgrade = preload("res://upgrades/life/upgrade_max_health.tscn")

const MAXIMUM_MOB_SPAWN_WAIT_TIME = 0.15
const MINIMUM_FAST_MOB_SPAWN_WAIT_TIME = 3
var mobs_killed = 0
var round = 0

func spawn_mob():
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	var generated_spawn_position = generate_spawn_position(%MobSpawnFollowPath)
	new_mob.global_position = generated_spawn_position
	new_mob.buff_mob(round)
	add_child(new_mob)
	
	
func spawn_fast_mob():
	var new_mob = preload("res://mobs/fast_mob.tscn").instantiate()
	var generated_spawn_position = generate_spawn_position(%MobSpawnFollowPath)
	new_mob.global_position = generated_spawn_position
	new_mob.buff_mob(round)
	add_child(new_mob)
	
	
func spawn_big_mob():
	var new_mob = preload("res://mobs/big_mob.tscn").instantiate()
	var generated_spawn_position = generate_spawn_position(%MobSpawnFollowPath)
	new_mob.global_position = generated_spawn_position
	add_child(new_mob)
	

func spawn_upgrades():
	var random_upgrade = [new_damage_upgrade, new_speed_upgrade, new_shuriken_upgrade].pick_random()
	var upgrade = random_upgrade.instantiate()
	var generated_spawn_position = generate_spawn_position(%UpgradeSpawnFollowPath)
	upgrade.global_position = generated_spawn_position
	add_child(upgrade)

func spawn_life_upgrades():
	var random_upgrade = [new_life_restore, new_life_upgrade].pick_random()
	var upgrade = random_upgrade.instantiate()
	var generated_spawn_position = generate_spawn_position(%UpgradeSpawnFollowPath)
	upgrade.global_position = generated_spawn_position
	add_child(upgrade)


func _on_spawn_fast_mob_timer_timeout() -> void:
	spawn_fast_mob()
	

func _on_spawn_mob_timer_timeout() -> void:
	spawn_mob()


func _on_spawn_big_mob_timer_timeout() -> void:
	spawn_big_mob()


func _on_spawn_upgrade_timer_timeout() -> void:
	spawn_upgrades()


func _on_spawn_life_upgrade_timer_timeout() -> void:
	spawn_life_upgrades()


func _on_increase_mob_spawn_ratio_timeout():
	if MAXIMUM_MOB_SPAWN_WAIT_TIME < %SpawnMobTimer.wait_time - %SpawnMobTimer.wait_time * 0.1:
		%SpawnMobTimer.wait_time -= %SpawnMobTimer.wait_time * 0.1
		return
	%SpawnMobTimer.wait_time = MAXIMUM_MOB_SPAWN_WAIT_TIME


func _on_increase_round_timeout() -> void:
	round += 1


func _on_player_game_over() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true


func updateMobsKilled(mob_xp: int) -> void:
	mobs_killed += 1
	%EnemiesKilledCounter.text = str(mobs_killed)
	%Player.gain_exp(mob_xp)


func update_health_indicators(health: float, max_health: float):
	var utils = Utils.new()
	var new_health_bar_size = 337 + (max_health / 100) * 10

	%HealthBar.value = health
	%HealthLabel.text = str(round(health))
	
	%HealthBar.max_value = max_health
	%HealthBar.size = Vector2(new_health_bar_size, %HealthBar.size.y)
	%MaxHealthLabel.text = str("/", max_health)


func update_exp_indicators(level: int, exp: int, next_level_exp: int):
	%LevelValue.text = str(level)
	%ExpBar.value = exp
	%ExpBar.max_value = next_level_exp
	%ExpLabel.text = str(exp, " / ", next_level_exp)


func _on_restart_game_button_button_down() -> void:
	%GameOverScreen.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()


# UTILS

func generate_spawn_position(follow_path: PathFollow2D):
	var spawn_position
	var dead_areas = %DeadArea.get_children()
	
	%MobSpawnFollowPath.progress_ratio = randf()
	var is_inside_dead_area = false
	
	for dead_area in dead_areas:
		var dead_area_position = dead_area.global_position - dead_area.shape.size / 2
		var dead_area_size = dead_area.shape.size
		var dead_area_final_position = dead_area_position + dead_area_size
		var mob_is_inside_x = %MobSpawnFollowPath.global_position.x > dead_area_position.x && %MobSpawnFollowPath.global_position.x < dead_area_final_position.x
		var mob_is_inside_y = %MobSpawnFollowPath.global_position.y > dead_area_position.y && %MobSpawnFollowPath.global_position.y < dead_area_final_position.y
		
		if mob_is_inside_x && mob_is_inside_y:
			is_inside_dead_area = true
			
	if is_inside_dead_area == true:
		return generate_spawn_position(follow_path)
	
	spawn_position = %MobSpawnFollowPath.global_position
	return spawn_position
