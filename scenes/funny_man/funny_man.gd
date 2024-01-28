extends Node2D

signal animation_finished()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func mock():
	$AnimationPlayer.play("mock")

func animation_end():
	animation_finished.emit()
