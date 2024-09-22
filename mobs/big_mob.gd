extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
var mob_speed = 220.0
var mob_damage = 5.0
var health = 50.0
var max_health = 50.0
var exp = 30

func _ready() -> void:
	%Slime.play_walk()
	%MobHealthBar.max_value = max_health
	%MobHealthBar.value = health

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mob_speed
	move_and_slide()
	
func take_damage(damage_value: float) -> void:
	var newHealth
	if health <= damage_value:
		newHealth = 0
	else:
		newHealth = health - damage_value
	
	health = newHealth
	%Slime.play_hurt()
	%MobHealthBar.value = newHealth
	
	if health <= 0:
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		var parent = get_parent()
		if parent.has_method("updateMobsKilled"):
			parent.updateMobsKilled(exp)

func buff_mob(buff_nivel: int):
	var health_buff = buff_nivel * 10
	var damage_buff = buff_nivel * 3
	var speed_buff = buff_nivel * 2
	
	max_health += health_buff
	health += health_buff
	mob_damage += damage_buff
	mob_speed += speed_buff
