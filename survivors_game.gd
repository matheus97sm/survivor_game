extends Node2D

@onready var new_damage_upgrade = preload("res://weapon/upgrade_damage.tscn")
@onready var new_speed_upgrade = preload("res://weapon/upgrade_speed.tscn")
@onready var new_shuriken_upgrade = preload("res://weapon/upgrade_shuriken.tscn")
@onready var new_life_restore = preload("res://upgrades/life/health_restore.tscn")
@onready var new_life_upgrade = preload("res://upgrades/life/upgrade_max_health.tscn")

const MAXIMUM_MOB_SPAWN_WAIT_TIME = 0.15
const MINIMUM_FAST_MOB_SPAWN_WAIT_TIME = 3
var mobs_killed = 0

func spawn_mob():
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	var generated_spawn_position = generate_spawn_position(%MobSpawnFollowPath)
	new_mob.global_position = generated_spawn_position
	add_child(new_mob)
	

func generate_spawn_position(follow_path: PathFollow2D):
	var spawn_position = Vector2(0.0, 0.0)
	var created_clean_spawn = false
	var dead_areas = %DeadArea.get_children()
	
	
	while !created_clean_spawn:
		%MobSpawnFollowPath.progress_ratio = randf()
		var is_inside_dead_area = false
		
		for dead_area in dead_areas:
			var dead_area_position = dead_area.global_position
			var dead_area_size = dead_area.shape.size
			var dead_area_final_position = dead_area_position + dead_area_size
			var mob_is_inside_x = %MobSpawnFollowPath.global_position.x > dead_area_position.x && %MobSpawnFollowPath.global_position.x < dead_area_final_position.x
			var mob_is_inside_y = %MobSpawnFollowPath.global_position.y > dead_area_position.y && %MobSpawnFollowPath.global_position.y < dead_area_final_position.y
			
			if mob_is_inside_x && mob_is_inside_y:
				print(mob_is_inside_x, mob_is_inside_y)
				is_inside_dead_area = true
				break
				
		if is_inside_dead_area:
			break
			
		spawn_position = %MobSpawnFollowPath.global_position
		created_clean_spawn = true
	
	return spawn_position
	
func spawn_fast_mob():
	var new_mob = preload("res://mobs/fast_mob.tscn").instantiate()
	%MobSpawnFollowPath.progress_ratio = randf()
	new_mob.global_position = %MobSpawnFollowPath.global_position
	add_child(new_mob)
	
	
func spawn_big_mob():
	var new_mob = preload("res://mobs/big_mob.tscn").instantiate()
	%MobSpawnFollowPath.progress_ratio = randf()
	new_mob.global_position = %MobSpawnFollowPath.global_position
	add_child(new_mob)
	

func spawn_upgrades():
	var random_upgrade = [new_damage_upgrade, new_speed_upgrade, new_shuriken_upgrade].pick_random()
	var upgrade = random_upgrade.instantiate()
	%UpgradeSpawnFollowPath.progress_ratio = randf()
	upgrade.global_position = %UpgradeSpawnFollowPath.global_position
	add_child(upgrade)

func spawn_life_upgrades():
	var random_upgrade = [new_life_restore, new_life_upgrade].pick_random()
	var upgrade = random_upgrade.instantiate()
	%UpgradeSpawnFollowPath.progress_ratio = randf()
	upgrade.global_position = %UpgradeSpawnFollowPath.global_position
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


func _on_player_game_over() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true


func updateMobsKilled() -> void:
	mobs_killed += 1
	%EnemiesKilledCounter.text = str(mobs_killed)


func _on_restart_game_button_button_down() -> void:
	%GameOverScreen.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("this area entered the path", area)
