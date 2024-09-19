extends Node2D

@onready var new_damage_upgrade = preload("res://weapon/upgrade_damage.tscn")
@onready var new_speed_upgrade = preload("res://weapon/upgrade_speed.tscn")

const MINIMUM_SPAWN_WAIT_TIME = 0.3
var mobs_killed = 0

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%MobSpawnFollowPath.progress_ratio = randf()
	new_mob.global_position = %MobSpawnFollowPath.global_position
	add_child(new_mob)

func spawn_upgrades():
	var random_upgrade = [new_damage_upgrade, new_speed_upgrade].pick_random()
	var upgrade = random_upgrade.instantiate()
	%UpgradeSpawnFollowPath.progress_ratio = randf()
	upgrade.global_position = %UpgradeSpawnFollowPath.global_position
	add_child(upgrade)


func _on_spawn_mob_timer_timeout() -> void:
	spawn_mob()


func _on_spawn_upgrade_timer_timeout() -> void:
	spawn_upgrades()

func _on_increase_mob_spawn_ratio_timeout():
	if MINIMUM_SPAWN_WAIT_TIME > %SpawnMobTimer.wait_time * 0.1:
		%SpawnMobTimer.wait_time -= %SpawnMobTimer.wait_time * 0.1
		return
	%SpawnMobTimer.wait_time = MINIMUM_SPAWN_WAIT_TIME


func _on_player_game_over() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true


func updateMobsKilled() -> void:
	mobs_killed += 1
	%EnemiesKilledCounter.text = str(mobs_killed)
