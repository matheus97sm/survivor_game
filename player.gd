extends CharacterBody2D

signal game_over
signal weapon_upgrade

var player_speed = 600
var max_health = 100.0
var health = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * player_speed
	move_and_slide()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			take_damage(mob.MOB_DAMAGE * delta)
		return

	if velocity.length() > 0.0:
		return %HappyBoo.play_walk_animation()
		
	return %HappyBoo.play_idle_animation()


func take_damage(damage_value: float) -> void:
	health -= damage_value
	update_health_bar()
	%HappyBoo.play_hurt_animation()
	if health <= 0.0:
		game_over.emit()


func upgrade_weapon(upgrade_type: String) -> void:
	weapon_upgrade.emit(upgrade_type)
	upgrade_sound()	

	
func upgrade_shuriken():
	%ShurikenAttack.upgrade_weapon() 
	upgrade_sound()	
	

func restore_life():
	var new_health = health + round(max_health * 0.25)
	
	if new_health < max_health:
		health = new_health
		update_health_bar()
		return
	
	health = max_health
	update_health_bar()
	upgrade_sound()	


func upgrade_life():
	max_health += 15
	update_health_bar() 
	upgrade_sound()	


func update_health_bar():
	%ProgressBar.value = health
	%ProgressBar.max_value = max_health
	

func upgrade_sound():
	var random_number = randf() * 0.3
	var random_pitch = 1 + random_number - 0.15
	%UpgradeSound.pitch_scale = random_pitch
	%UpgradeSound.play()
