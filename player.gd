extends CharacterBody2D

signal game_over
signal weapon_upgrade

const PLAYER_SPEED = 600
var max_health = 100.0
var health = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * PLAYER_SPEED
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
	%ProgressBar.value = health
	%HappyBoo.play_hurt_animation()
	if health <= 0.0:
		game_over.emit()

func upgrade_weapon(upgrade_type: String) -> void:
	weapon_upgrade.emit(upgrade_type)
