extends Node2D


func _ready() -> void:
	Events.connect("started_day", self, 'on_day_started')
	on_day_started()

func on_day_started() -> void:
	$AnimationPlayer.play("time_passing")

