extends Node2D


func play_idle_animation():
	var current_animation = %AnimationPlayer.get_current_animation()
	if current_animation != "hurt":
		%AnimationPlayer.play("idle")

func play_walk_animation():
	var current_animation = %AnimationPlayer.get_current_animation()
	if current_animation != "hurt":
		%AnimationPlayer.play("walk")

func play_hurt_animation():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("idle")
	
