extends Node2D


func _ready() -> void:
	play_idle()


func play_idle() -> void:
	%AnimationPlayer.play("idle")
